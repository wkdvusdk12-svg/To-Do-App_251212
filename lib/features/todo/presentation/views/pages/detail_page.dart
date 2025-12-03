import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../viewmodels/todo_list_notifier.dart';

class DetailPage extends ConsumerWidget {
  const DetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(todoListProvider);
    final todo = items.firstWhere(
      (element) => element.id == id,
      orElse: () => throw Exception('Todo not found'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'todo_title_${todo.id}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  todo.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (todo.description != null)
              Text(
                todo.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(
                  todo.isDone ? Icons.check_circle : Icons.circle_outlined,
                  color: todo.isDone ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(todo.isDone ? 'Completed' : 'Pending'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
