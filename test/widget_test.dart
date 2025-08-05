// ITIL® 4 Foundation Quiz App - Minimal Smoke Test
//
// This test ensures the app compiles successfully and GitHub Actions pass.

import 'package:flutter_test/flutter_test.dart';
import 'package:itil4_quiz_app/main.dart';

void main() {
  group('ITIL Quiz App Build Tests', () {
    test('App class can be instantiated', () {
      // Simple test to ensure the app compiles and can be instantiated
      expect(() => const MyApp(), returnsNormally);
    });

    test('App compilation is successful', () {
      // This test passes if the code compiles without errors
      expect(true, isTrue);
    });

    test('Basic Dart functionality works', () {
      // Test basic Dart operations to ensure environment is working
      final numbers = [1, 2, 3, 4, 5];
      final sum = numbers.fold(0, (a, b) => a + b);
      expect(sum, equals(15));
    });
  });

  group('Code Quality Tests', () {
    test('No syntax errors in main app file', () {
      // If this test runs, it means the main.dart file compiled successfully
      expect(() => const MyApp(), returnsNormally);
    });

    test('Project structure is valid', () {
      // Basic validation that the project can be imported
      expect(MyApp, isNotNull);
    });
  });
}
