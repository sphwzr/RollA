import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kniffel/domain/general/highscore.dart';
import 'package:kniffel/domain/general/highscore_storage.dart';
import 'package:kniffel/presentation/general/highscore_item.dart';
import 'package:kniffel/presentation/general/highscore.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'highscore_storage_test.mocks.dart';

@GenerateMocks([HighscoreStorage])
void main() {
  group('HighscoreScreen', () {
    late MockHighscoreStorage mockStorage;

    setUp(() {
      mockStorage = MockHighscoreStorage();
    });

    testWidgets('displays loading indicator while waiting for data',
        (WidgetTester tester) async {
      when(mockStorage.getHighscores()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: HighscoreScreen(storage: mockStorage),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

/*
    testWidgets('displays error message when there is an error', (WidgetTester tester) async {
      when(mockStorage.getHighscores()).thenThrow(Exception('Failed to load highscores'));

      await tester.pumpWidget(
        MaterialApp(
          home: HighscoreScreen(storage: mockStorage),
        ),
      );

      await tester.pump(); // Rebuild the widget with the error

      expect(find.text('Error loading highscores'), findsOneWidget);
    });
*/
    testWidgets('displays message when there are no highscores',
        (WidgetTester tester) async {
      when(mockStorage.getHighscores()).thenAnswer((_) async => []);

      await tester.pumpWidget(
        MaterialApp(
          home: HighscoreScreen(storage: mockStorage),
        ),
      );

      await tester.pump(); // Rebuild the widget with the empty data

      expect(find.text('No highscores available'), findsOneWidget);
    });

    testWidgets('displays list of highscores', (WidgetTester tester) async {
      final highscores = [
        Highscore(name: 'Player 1', score: 100, date: DateTime.now()),
        Highscore(name: 'Player 2', score: 90, date: DateTime.now()),
      ];

      when(mockStorage.getHighscores()).thenAnswer((_) async => highscores);

      await tester.pumpWidget(
        MaterialApp(
          home: HighscoreScreen(storage: mockStorage),
        ),
      );

      await tester.pump(); // Rebuild the widget with the data

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(HighscoreItem), findsNWidgets(2));
    });
  });
}
