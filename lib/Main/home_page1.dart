// 앱 초기 화면

import 'package:flutter/material.dart';

import '../Core/app_theme.dart';
import '../Core/variable_colors.dart';
import '../Core/fixed_colors.dart';
import '../Core/to_do_entity.dart';

import '../View/add_to_do_dialog.dart';
import '../View/no_to_do.dart';
import '../View/to_do_view.dart';

class HomePage extends StatefulWidget {
  // 변화가 있어야 하는 화면이니까 StatefulWidget 사용
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ToDoEntity> todos = [];
  // 이 페이지는 투두 리스트를 가져야 함.
  // 투투 데이터를 가질 수 있는 리스트를 만들어줌
  //

  // ((바텀시트에서 ToDoEntity를 받아 리스트에 반영))
  Future<void> _addTodo() async {
    final ToDoEntity? newTodo = await showModalBottomSheet<ToDoEntity>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const AddToDoDialog(),
    );
    if (newTodo != null) {
      setState(() => todos = [...todos, newTodo]);
    }
  }

  // 즐겨찾기
  void toggleFavorite(ToDoEntity todo) {
    final idx = todos.indexOf(todo);
    if (idx < 0) return;
    setState(() {
      todos[idx] = ToDoEntity(
        title: todo.title,
        description: todo.description,
        isFavorite: !todo.isFavorite,
        isDone: todo.isDone,
      );
    });
  }

  // 완료
  void toggleDone(ToDoEntity todo) {
    final idx = todos.indexOf(todo);
    if (idx < 0) return;
    setState(() {
      todos[idx] = ToDoEntity(
        title: todo.title,
        description: todo.description,
        isFavorite: todo.isFavorite,
        isDone: !todo.isDone,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final vc = vrc(context);
    final fc = fxc(context);

    return Scaffold(
      // MaterialApp이 전체의 틀이라면, Scaffold는 한 페이지의 틀을 담당
      // AppBar, body, Button, BottomNavigationBar 등
      backgroundColor: vc.background300,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: vc.background200,
        scrolledUnderElevation: 0,
        title: Text(
          widget.title,
          // 밖에서 받은 인자를 스캐폴드 내에서 쓰고 싶다면 widget을 붙여줘야 함.
          style: TextStyle(
            color: vc.textColor200,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: todos.isEmpty
          ? NoToDo(title: widget.title)
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => ToDoView(
                  toDo: todos[index],
                  onToggleFavorite: () => toggleFavorite(todos[index]),
                  onToggleDone: () => toggleDone(todos[index]),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        // 오른쪽 하단에 있는 버튼
        foregroundColor: Colors.white,
        backgroundColor: fc.brandColor,
        shape: const CircleBorder(),
        onPressed: _addTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add_rounded, size: 24),
      ),
    );
  }
}

