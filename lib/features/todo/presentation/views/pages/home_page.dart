import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:tap_debouncer/tap_debouncer.dart';
import '../../viewmodels/todo_list_notifier.dart';
import '../../../domain/entities/todo.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(todoListProvider);
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200) {
          ref.read(todoListProvider.notifier).fetchMore();
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: RefreshIndicator(
        onRefresh: () => ref.read(todoListProvider.notifier).refresh(),
        child: items.isEmpty
            ? const Center(child: Text('할 일이 없습니다'))
            : ListView.separated(
                controller: scrollController,
                itemCount: items.length + 1, // +1 for loading indicator
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  if (i == items.length) {
                    // Loading indicator at bottom
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return _Tile(item: items[i]);
                },
              ),
      ),
      floatingActionButton: TapDebouncer(
        onTap: () async {
          final r = await _ask(context);
          if (r != null && r.trim().isNotEmpty) {
            await ref.read(todoListProvider.notifier).add(r.trim());
          }
        },
        builder: (BuildContext context, TapDebouncerFunc? onTap) {
          return FloatingActionButton(
            onPressed: onTap,
            child: const Icon(Icons.add),
          );
        },
      ),
    );
  }

  Future<String?> _ask(BuildContext context) async {
    final c = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('할 일 추가'),
        content: SingleChildScrollView(
          child: TextField(controller: c, decoration: const InputDecoration(labelText: '제목')),
        ),
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
    return TapDebouncer(
      onTap: () async => context.go('/detail/${item.id}'),
      builder: (context, onTap) => ListTile(
        onTap: onTap,
        title: Hero(
        tag: 'todo_title_${item.id}',
        child: Material(
          color: Colors.transparent,
          child: Text(
            item.title,
            style: TextStyle(
              decoration: item.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
        ),
      ),
        subtitle: item.description == null ? null : Text(item.description!),
        leading: TapDebouncer(
          onTap: () async =>
              ref.read(todoListProvider.notifier).toggleFav(item.id, !item.isFavorite),
          builder: (context, onTap) => IconButton(
            icon: Icon(item.isFavorite ? Icons.star : Icons.star_border),
            onPressed: onTap,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: item.isDone,
              onChanged: (v) =>
                  ref.read(todoListProvider.notifier).toggleDone(item.id, v ?? false),
            ),
            TapDebouncer(
              onTap: () async => ref.read(todoListProvider.notifier).remove(item.id),
              builder: (context, onTap) => IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: onTap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}