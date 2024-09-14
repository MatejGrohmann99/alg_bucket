import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ee', () {
    print(
      jsonEncode(
        <String, List<int>>{
          '014': [0, 1, 4],
          '01': [1],
          '012': [0, 1, 2],
          '02': [2],
          '023': [0, 2, 3],
          '03': [3],
          '034': [0, 3, 4],
          '04': [4],
        },
      ),
    );
  });
}
