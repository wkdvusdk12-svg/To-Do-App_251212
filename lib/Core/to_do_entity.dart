// To Do 항목 "데이터 구조" 정의 클래스
// 가장 먼저 입력해야 함. 어떤 속성을 가져야 하는지 명확하게.
// '할 일'이 가져야 하는 필수 정보들


class ToDoEntity {
  ToDoEntity({
    required this.title, 
    required this.description, 
    required this.isFavorite, 
    this.isDone = false,
    // 처음에 값을 준게 없어서 일단 false를 줌.
  });

  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;


  // @override
  // String toString() {
  //   return 'ToDo(title: $title, description: $description, isFavorite: $isFavorite, isDone: $isDone)';
  // }
}
