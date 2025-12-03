import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';

@freezed
abstract class ToDo with _$ToDo {
  factory ToDo({
    required String id,
    required String title,
    String? description,
    @Default(false) bool isFavorite,
    @Default(false) bool isDone,
    DateTime? createdAt,
  }) = _ToDo;
}