import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../data/repositories/todo_repository_memory.dart';

part 'todo_list_notifier.g.dart';

@Riverpod(keepAlive: true)
ToDoRepository todoRepository(TodoRepositoryRef ref) {
  return ToDoRepositoryMemory();
}

@Riverpod(keepAlive: true)
class TodoList extends _$TodoList {
  late ToDoRepository _repo;
  bool _isLoading = false;
  bool _hasMore = true;

  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  @override
  List<ToDo> build() {
    _repo = ref.watch(todoRepositoryProvider);
    // Initial fetch is handled by the constructor in original code,
    // but here we should probably fetch in build or use FutureProvider?
    // Original code: super(const []) { refresh(); }
    // We can call refresh() here but it's async.
    // Ideally, we should return Future<List<ToDo>> (AsyncNotifier).
    // But to keep signature List<ToDo> (Notifier), we initialize with empty and fetch.
    // However, side-effects in build are discouraged.
    // Let's mimic the original behavior: start empty, then fetch.
    // We can use a microtask or just call refresh.
    Future.microtask(() => refresh());
    return [];
  }

  Future<void> refresh() async {
    if (_isLoading) return;
    _isLoading = true;
    try {
      final items = await _repo.fetch(limit: 15);
      state = items;
      _hasMore = items.length >= 15;
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchMore() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;
    try {
      final lastItem = state.isNotEmpty ? state.last : null;
      final items = await _repo.fetch(limit: 15, startAfter: lastItem);
      if (items.isEmpty) {
        _hasMore = false;
      } else {
        state = [...state, ...items];
        if (items.length < 15) _hasMore = false;
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> add(String title, {String? description}) async {
    final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
    final tempTodo = ToDo(
      id: tempId,
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    final previousState = state;
    state = [tempTodo, ...state];

    try {
      final newTodo = await _repo.create(title: title, description: description);
      state = [
        for (final t in state)
          if (t.id == tempId) newTodo else t
      ];
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> toggleDone(String id, bool v) async {
    final previousState = state;
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isDone: v) else todo
    ];

    try {
      await _repo.toggleDone(id, v);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> toggleFav(String id, bool v) async {
    final previousState = state;
    state = [
      for (final todo in state)
        if (todo.id == id) todo.copyWith(isFavorite: v) else todo
    ];

    try {
      await _repo.toggleFavorite(id, v);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }

  Future<void> remove(String id) async {
    final previousState = state;
    state = state.where((todo) => todo.id != id).toList();

    try {
      await _repo.delete(id);
    } catch (e) {
      state = previousState;
      rethrow;
    }
  }
}