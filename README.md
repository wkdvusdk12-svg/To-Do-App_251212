## To. 튜터님

안녕하세요 튜터님!
지난 과제 피드백 주셔서 감사합니다🙇‍♂️

말씀해 주신 부분들 참고하여 수정해 보았습니다.

<br>

---

## 📝 수정 사항

피드백 주신 5가지 내용을 아래와 같이 코드에 반영했습니다.

1. **StreamController 종료 처리**
   - `dispose()` 메서드를 추가하여 `close()`가 호출되도록 수정했습니다.

2. **데이터 불변성**
   - 데이터를 전달할 때 `List.unmodifiable`을 적용했습니다.

3. **fetch 메서드 부작용 (Side Effect)**
   - `fetch` 안에서 원본 리스트를 바로 정렬(`sort`)하지 않도록 수정했습니다.

4. **Clean Architecture & Freezed**
   - `freezed`를 적용하고, `json_serializable`(.g.dart)을 통해 통신 코드를 구현했습니다.

5. **Riverpod Generator**
   - 뷰모델을 `generator` 방식으로 변경하여 적용했습니다.
