// 리스트 비어 있을 때

import 'package:flutter/material.dart';

import '../Core/variable_colors.dart';

class NoToDo extends StatelessWidget {
  const NoToDo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final vc = vrc(context);

    return Container(
      width: double.infinity,
      // 마진이랑 패딩의 차이는?
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: vc.background200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/cat.webp', width: 100, height: 100),

          const SizedBox(height: 12),
          Text(
            '아직 할 일이 없음',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: vc.textColor100,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '할 일을 추가하고 $title에서\n할 일을 추적하세요.',
            textAlign: TextAlign.center,
            style: TextStyle(color: vc.textColor100, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
