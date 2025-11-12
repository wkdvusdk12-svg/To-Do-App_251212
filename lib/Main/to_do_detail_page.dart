// 할 일 항목 탭, 상세 화면

import 'package:flutter/material.dart';
import '../Core/variable_colors.dart';
import '../Core/to_do_entity.dart';

class ToDoDetailPage extends StatefulWidget {
  const ToDoDetailPage({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
  });

  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;

  @override
  State<ToDoDetailPage> createState() => _ToDoDetailPageState();
}

class _ToDoDetailPageState extends State<ToDoDetailPage> {
  late bool _isFavorite; // 왜 

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.toDo.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    final vc = vrc(context);

    return Scaffold(
      backgroundColor: vc.background300,
      appBar: AppBar(
        backgroundColor: vc.background200,
        elevation: 0,
        iconTheme: IconThemeData(color: vc.textColor200),
        title: Text('상세', style: TextStyle(color: vc.textColor200)),
        actions: [
          InkWell(
            onTap: () {
              setState(() => _isFavorite = !_isFavorite);
              widget.onToggleFavorite();
            },
            child: SizedBox(
              width: 48,
              height: 48,
              child: Center(
                child: Icon(
                  _isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                  size: 24,
                  color: vc.textColor200,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: vc.background300,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.toDo.title,
              style: TextStyle(
                color: vc.textColor200,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.short_text_rounded,
                  size: 24,
                  color: vc.textColor200,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.toDo.description ?? '세부정보 추가',
                    style: TextStyle(
                      color: vc.textColor200,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
