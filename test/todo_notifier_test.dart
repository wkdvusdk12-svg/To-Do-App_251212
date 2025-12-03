import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_application_2/features/todo/domain/entities/todo.dart';
import 'package:todo_application_2/features/todo/domain/repositories/todo_repository.dart';
import 'package:todo_application_2/features/todo/presentation/viewmodels/todo_list_notifier.dart';

class MockToDoRepository implements ToDoRepository {
  final _controller = StreamController<List<ToDo>>.broadcast();
  List<ToDo> _items = [];
  bool shouldFail = false;

  @override
  Future<List<ToDo>> fetch({int limit = 15, ToDo? startAfter}) async {
    if (shouldFail) throw Exception('Failed to fetch');
    return _items;
  }

  @override
  Future<ToDo> create({required String title, String? description}) async {
    if (shouldFail) throw Exception('Failed to create');
    final todo = ToDo(id: 'real_id', title: title, description: description);
    _items = [..._items, todo];
    _controller.add(_items);
    return todo;
  }

  @override
  Future<void> delete(String id) async {
    if (shouldFail) throw Exception('Failed to delete');
    _items = _items.where((t) => t.id != id).toList();
    _controller.add(_items);
  }

  @override
  Future<void> toggleDone(String id, bool value) async {
    if (shouldFail) throw Exception('Failed to toggle done');
    _items = [
      for (final t in _items)
        if (t.id == id) t.copyWith(isDone: value) else t
    ];
    _controller.add(_items);
  }

  @override
  Future<void> toggleFavorite(String id, bool value) async {
    if (shouldFail) throw Exception('Failed to toggle favorite');
    _items = [
      for (final t in _items)
        if (t.id == id) t.copyWith(isFavorite: value) else t
    ];
    _controller.add(_items);
  }

  @override
  Future<void> update(ToDo todo) async {
    // Not implemented for this test
  }
}

void main() {
  late MockToDoRepository mockRepo;
  late ToDoListNotifier notifier;

  setUp(() {
    mockRepo = MockToDoRepository();
    notifier = ToDoListNotifier(mockRepo);
  });

  tearDown(() {
    notifier.dispose();
  });

  test('add updates state immediately (optimistic)', () async {
    // Act
    final future = notifier.add('Test Title');

    // Assert: State should have the item immediately (with temp id)
    expect(notifier.state.length, 1);
    expect(notifier.state.first.title, 'Test Title');
    expect(notifier.state.first.id, startsWith('temp_'));

    await future;

    // Assert: State should eventually be consistent with repo (real id)
    // Note: In this simple mock, the repo emits the new list with the real item,
    // which replaces the optimistic state.
    expect(notifier.state.length, 1);
    expect(notifier.state.first.id, 'real_id');
  });

  test('add reverts state on error', () async {
    mockRepo.shouldFail = true;

    // Act & Assert
    try {
      await notifier.add('Test Title');
      fail('Should have thrown');
    } catch (e) {
      expect(notifier.state, isEmpty);
    }
  });

  test('toggleDone updates state immediately', () async {
    // Arrange
    // Arrange
    final todo = ToDo(id: '1', title: 'Test');
    mockRepo._items = [todo];
    await notifier.refresh(); // Load initial data
    expect(notifier.state.first.isDone, false);

    // Act
    final future = notifier.toggleDone('1', true);

    // Assert: Optimistic update
    expect(notifier.state.first.isDone, true);

    await future;
    expect(notifier.state.first.isDone, true);
  });

  test('toggleDone reverts state on error', () async {
    // Arrange
    final todo = ToDo(id: '1', title: 'Test');
    mockRepo._items = [todo];
    await notifier.refresh();
    mockRepo.shouldFail = true;

    // Act
    try {
      await notifier.toggleDone('1', true);
      fail('Should have thrown');
    } catch (e) {
      expect(notifier.state.first.isDone, false);
    }
  });

  test('remove updates state immediately', () async {
    // Arrange
    final todo = ToDo(id: '1', title: 'Test');
    mockRepo._items = [todo];
    await notifier.refresh();

    // Act
    final future = notifier.remove('1');

    // Assert: Optimistic update
    expect(notifier.state, isEmpty);

    await future;
    expect(notifier.state, isEmpty);
  });

  test('remove reverts state on error', () async {
    // Arrange
    final todo = ToDo(id: '1', title: 'Test');
    mockRepo._items = [todo];
    await notifier.refresh();
    mockRepo.shouldFail = true;

    // Act
    try {
      await notifier.remove('1');
      fail('Should have thrown');
    } catch (e) {
      expect(notifier.state.length, 1);
    }
  });
}
