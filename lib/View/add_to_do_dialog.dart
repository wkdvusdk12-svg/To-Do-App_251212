// 버튼 클릭 시 제목, 설명, 즐겨찾기 상태 관리

import 'package:flutter/material.dart';

import '../Core/variable_colors.dart';
import '../Core/to_do_entity.dart';

class AddToDoDialog extends StatefulWidget {
  const AddToDoDialog({super.key});

  @override
  State<AddToDoDialog> createState() => _AddToDoDialogState();
}

class _AddToDoDialogState extends State<AddToDoDialog> {
  bool isFavorite = false;
  bool isDescriptionActivated = false;

  // ((입력 컨트롤러/포커스))
  final _focusNode = FocusNode();
  final _controllerTitle = TextEditingController();
  final _controllerDesc = TextEditingController();

  void saveToDo() {
    final title = _controllerTitle.text.trim();
    final desc = _controllerDesc.text.trim().isEmpty
        ? null
        : _controllerDesc.text.trim();

    if (title.isNotEmpty) {
      final result = ToDoEntity(
        title: title,
        description: desc,
        isFavorite: isFavorite,
      );
      Navigator.of(context).pop(result); // ((ToDoEntity 반환 후 닫기))
    } else {
      //
      // 할 일 적지 않고 저장 시 안내 문구 팝업으로 뜸.
      // 텍스트필드 위에서 보이게 변경해야 함.

      // Navigator.push(context, MetarialPageRute(bilder: (context) => 세컨드페이지()));
      // if (number != null){

      // }
      // Navigator.pop(context, 123) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('할 일을 입력해주세요.'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
      // ((타이틀 필드에 포커스 유지))
      _focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    _controllerTitle.dispose();
    _controllerDesc.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vc = vrc(context);

    return SafeArea(
      top: false,
      child: Container(
        decoration: BoxDecoration(
          color: vc.background100,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          MediaQuery.of(context).viewInsets.bottom, // 키보드 높이만큼 여백줌
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerTitle,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '새 할 일',
                hintStyle: TextStyle(color: vc.textColor100, fontSize: 16),
              ),
              style: TextStyle(color: vc.textColor200, fontSize: 16),
              onSubmitted: (_) => saveToDo(),
              onChanged: (_) => setState(() {}),
            ),

            if (isDescriptionActivated) ...[
              // ... 이유
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: TextField(
                  controller: _controllerDesc,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '세부정보 추가',
                  ),
                  style: TextStyle(
                    color: vc.textColor200,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (!isDescriptionActivated)
                      InkWell(
                        onTap: () =>
                            setState(() => isDescriptionActivated = true),
                        child: const SizedBox(
                          width: 40,
                          height: 40,
                          child: Center(
                            child: Icon(Icons.short_text_rounded, size: 24),
                          ),
                        ),
                      ),
                    const SizedBox(width: 12),
                    InkWell(
                      onTap: () => setState(() => isFavorite = !isFavorite),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: Center(
                          child: Icon(
                            isFavorite
                                ? Icons.star_rounded
                                : Icons.star_border_rounded,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: saveToDo,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Text(
                      '저장',
                      style: TextStyle(
                        color: _controllerTitle.text.trim().isNotEmpty
                            ? vc.textColor200
                            : vc.textColor100,
                        fontSize: 16,
                      ),
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
