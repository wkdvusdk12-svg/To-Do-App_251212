import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../ViewModel/todo_list_notifier.dart';
import '../Data/models/todo.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(todoListProvider);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: items.isEmpty
          ? const Center(child: Text('할 일이 없습니다'))
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (_, i) => _Tile(item: items[i]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final r = await _ask(context);
          if (r != null && r.trim().isNotEmpty) {
            await ref.read(todoListProvider.notifier).add(r.trim());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<String?> _ask(BuildContext context) async {
    final c = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('할 일 추가'),
        content: TextField(controller: c, decoration: const InputDecoration(labelText: '제목')),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          FilledButton(onPressed: () => Navigator.pop(context, c.text), child: const Text('추가')),
        ],
      ),
    );
  }
}

class _Tile extends ConsumerWidget {
  const _Tile({required this.item});
  final ToDo item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        item.title,
        style: TextStyle(
          decoration: item.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: item.description == null ? null : Text(item.description!),
      leading: IconButton(
        icon: Icon(item.isFavorite ? Icons.star : Icons.star_border),
        onPressed: () => ref.read(todoListProvider.notifier).toggleFav(item.id, !item.isFavorite),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: item.isDone,
            onChanged: (v) => ref.read(todoListProvider.notifier).toggleDone(item.id, v ?? false),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => ref.read(todoListProvider.notifier).remove(item.id),
          ),
        ],
      ),
    );
  }
}