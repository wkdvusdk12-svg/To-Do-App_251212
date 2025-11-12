// 할 일 리스트 표시


import 'package:flutter/material.dart';

import '../Core/variable_colors.dart';

import '../Core/to_do_entity.dart';

import '../Main/to_do_detail_page.dart';

class ToDoView extends StatelessWidget {
  const ToDoView({
    super.key,
    required this.toDo, // 표시할 ToDo 객체
    required this.onToggleFavorite, // 즐겨찾기 토글 콜백
    required this.onToggleDone, // 완료 토글 콜백
  });

  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    final vc = vrc(context); 

    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: vc.background200,
        borderRadius: BorderRadius.circular(12), 
      ),
      child: Row(
        children: [
          
          InkWell(
            onTap: onToggleDone,
            child: const SizedBox(
              width: 40,
              height: 40,
              // 클릭 시 원 내부 채워지는 걸로 변경되도록 수정 (아래 코드 참고)
              child: Center(child: Icon(Icons.circle_outlined)),
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ToDoDetailPage(
                      toDo: toDo,
                      onToggleFavorite: onToggleFavorite,
                    ),
                  ),
                );
              },
              child: Text(
                toDo.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: vc.textColor200,
                  fontSize: 16,
                  decoration: toDo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          InkWell(
            onTap: onToggleFavorite,
            child: SizedBox(
              width: 40,
              height: 40,
              child: Center(
                child: Icon(
                  // 이 부분을 완료 표시에도 동일하게 적용해야 함
                  toDo.isFavorite
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: vc.textColor200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
