import 'package:flutter_test/flutter_test.dart';
import 'package:my_chat_client/main_conversations_list/utils/ListUtils.dart';

void main() {
  group('List utils tests', () {
    test('Empty list should be equal', () async {
      //given
      ListUtils listUtils = ListUtils();

      //when
      bool result = listUtils.isEqualsAllListElements([], []);

      //then
      expect(true, result);
    });

    test('Different list should not be equals', () async {
      //given
      ListUtils listUtils = ListUtils();

      //when
      bool result = listUtils.isEqualsAllListElements([1,2,5], [2,44]);

      //then
      expect(false, result);
    });

    test('Same list should be equals', () async {
      //given
      ListUtils listUtils = ListUtils();

      //when
      bool result = listUtils.isEqualsAllListElements([2,44], [2,44]);

      //then
      expect(true, result);
    });


  });
}