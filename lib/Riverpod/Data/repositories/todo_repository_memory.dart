import 'dart:async';
import '../models/todo.dart';
import 'todo_repository.dart';

class ToDoRepositoryMemory implements ToDoRepository {
  final _items = <ToDo>[];
  final _ctrl = StreamController<List<ToDo>>.broadcast();

  ToDoRepositoryMemory() {
    _items.addAll([
      ToDo(id: '1', title: '샘플 작업 1', description: '예시'),
      ToDo(id: '2', title: '샘플 작업 2', isFavorite: true),
    ]);
    _emit();
  }

  void _emit() => _ctrl.add(List.unmodifiable(_items));
  String _newId() => DateTime.now().microsecondsSinceEpoch.toString();

  @override
  Stream<List<ToDo>> watchAll() => _ctrl.stream;

  @override
  Future<ToDo> create({required String title, String? description}) async {
    final t = ToDo(id: _newId(), title: title, description: description);
    _items.insert(0, t);
    _emit();
    return t;
  }

  @override
  Future<void> update(ToDo todo) async {
    final i = _items.indexWhere((e) => e.id == todo.id);
    if (i != -1) {
      _items[i] = todo;
      _emit();
    }
  }

  @override
  Future<void> toggleDone(String id, bool value) async {
    final i = _items.indexWhere((e) => e.id == id);
    if (i != -1) {
      _items[i] = _items[i].copyWith(isDone: value);
      _emit();
    }
  }

  @override
  Future<void> toggleFavorite(String id, bool value) async {
    final i = _items.indexWhere((e) => e.id == id);
    if (i != -1) {
      _items[i] = _items[i].copyWith(isFavorite: value);
      _emit();
    }
  }

  @override
  Future<void> delete(String id) async {
    _items.removeWhere((e) => e.id == id);
    _emit();
  }
}