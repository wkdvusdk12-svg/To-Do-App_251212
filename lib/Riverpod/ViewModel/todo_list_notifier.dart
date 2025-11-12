import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Data/models/todo.dart';
import '../Data/repositories/todo_repository.dart';
import '../Data/repositories/todo_repository_memory.dart';

final todoRepositoryProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepositoryMemory();
});

final todoListProvider =
    StateNotifierProvider<ToDoListNotifier, List<ToDo>>((ref) {
  final repo = ref.watch(todoRepositoryProvider);
  return ToDoListNotifier(repo);
});

class ToDoListNotifier extends StateNotifier<List<ToDo>> {
  ToDoListNotifier(this._repo) : super(const []) {
    var _sub = _repo.watchAll().listen((items) => state = items);
  }

  final todoRepositoryProvider = Provider<ToDoRepository>((ref) {
  return ToDoRepositoryMemory();
});

  var _repo;
  
  get _sub => null;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  Future<void> add(String title, {String? description}) async {
    await _repo.create(title: title, description: description);
  }

  Future<void> toggleDone(String id, bool v) => _repo.toggleDone(id, v);
  Future<void> toggleFav(String id, bool v) => _repo.toggleFavorite(id, v);
  Future<void> remove(String id) => _repo.delete(id);
}