import '../models/todo.dart';

abstract class ToDoRepository {
  Stream<List<ToDo>> watchAll();
  Future<ToDo> create({required String title, String? description});
  Future<void> update(ToDo todo);
  Future<void> toggleDone(String id, bool value);
  Future<void> toggleFavorite(String id, bool value);
  Future<void> delete(String id);
}
