import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:okookie/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.cookie).existsSync(), isTrue);
  });
}
