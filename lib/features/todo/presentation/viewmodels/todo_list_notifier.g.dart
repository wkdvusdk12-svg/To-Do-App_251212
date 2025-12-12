// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todoRepositoryHash() => r'39626719af9c0b35cfa0d0176a7d9271e59904ae';

/// See also [todoRepository].
@ProviderFor(todoRepository)
final todoRepositoryProvider = Provider<ToDoRepository>.internal(
  todoRepository,
  name: r'todoRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodoRepositoryRef = ProviderRef<ToDoRepository>;
String _$todoListHash() => r'4651e293117e9b026aacfc8b23de21bcac33ff6e';

/// See also [TodoList].
@ProviderFor(TodoList)
final todoListProvider = NotifierProvider<TodoList, List<ToDo>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TodoList = Notifier<List<ToDo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
