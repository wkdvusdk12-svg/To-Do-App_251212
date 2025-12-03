import 'dart:async';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class ToDoRepositoryMemory implements ToDoRepository {
  final _items = <ToDo>[];
  final _ctrl = StreamController<List<ToDo>>.broadcast();

  ToDoRepositoryMemory() {
    _items.addAll([
      ToDo(id: '1', title: '샘플 작업 1', description: '예시'),
      ToDo(id: '2', title: '샘플 작업 2', isFavorite: true),
    ]);
    _emit();
    _ctrl.add(List.unmodifiable(_items));
  }

  void _emit() => _ctrl.add(List.unmodifiable(_items));


  @override
  Future<List<ToDo>> fetch({int limit = 15, ToDo? startAfter}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Sort by createdAt descending (nulls last or first? usually new items have createdAt)
    // For this mock, let's assume all have createdAt or we treat null as old.
    _items.sort((a, b) {
      if (a.createdAt == null && b.createdAt == null) return 0;
      if (a.createdAt == null) return 1;
      if (b.createdAt == null) return -1;
      return b.createdAt!.compareTo(a.createdAt!);
    });

    int startIndex = 0;
    if (startAfter != null) {
      final index = _items.indexWhere((item) => item.id == startAfter.id);
      if (index != -1) {
        startIndex = index + 1;
      }
    }

    if (startIndex >= _items.length) return [];

    final endIndex = (startIndex + limit).clamp(0, _items.length);
    return _items.sublist(startIndex, endIndex);
  }

  @override
  Future<ToDo> create({required String title, String? description}) async {
    final todo = ToDo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _items.insert(0, todo); // Insert at beginning for "latest"
    _ctrl.add(_items);
    return todo;
  }

  @override
  Future<void> update(ToDo todo) async {
    final index = _items.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _items[index] = todo;
      _ctrl.add(_items);
    }
  }

  @override
  Future<void> toggleDone(String id, bool value) async {
    final index = _items.indexWhere((t) => t.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(isDone: value);
      _ctrl.add(_items);
    }
  }

  @override
  Future<void> toggleFavorite(String id, bool value) async {
    final index = _items.indexWhere((t) => t.id == id);
    if (index != -1) {
      _items[index] = _items[index].copyWith(isFavorite: value);
      _ctrl.add(_items);
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((t) => t.id == id);
    _ctrl.add(_items);
  }
}