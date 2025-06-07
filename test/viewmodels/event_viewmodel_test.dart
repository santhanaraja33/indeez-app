import 'package:flutter_test/flutter_test.dart';
import 'package:music_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('EventViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
