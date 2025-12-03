import '../entities/todo.dart';

abstract class ToDoRepository {
  Future<List<ToDo>> fetch({int limit = 15, ToDo? startAfter});
  Future<ToDo> create({required String title, String? description});
  Future<void> update(ToDo todo);
  Future<void> toggleDone(String id, bool value);
  Future<void> toggleFavorite(String id, bool value);
  Future<void> delete(String id);
}
