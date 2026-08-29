import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/core/widgets/empty_view.dart';
import 'package:movies_app/core/widgets/error_view.dart';
import 'package:movies_app/features/search/presentation/widgets/search_bar_widget.dart';

void main() {
  group('Core UI Components Widget Tests', () {
    testWidgets('ErrorView renders message and triggers retry callback', (tester) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ErrorView(
              message: 'Failed to load data',
              onRetry: () {
                retryPressed = true;
              },
            ),
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Failed to load data'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      await tester.pump();

      expect(retryPressed, isTrue);
    });

    testWidgets('EmptyView renders title and description', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyView(
              title: 'No Movies Available',
              message: 'Check back later for more updates.',
            ),
          ),
        ),
      );

      expect(find.text('No Movies Available'), findsOneWidget);
      expect(find.text('Check back later for more updates.'), findsOneWidget);
    });

    testWidgets('SearchBarWidget accepts input and clears text', (tester) async {
      String query = '';
      bool cleared = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchBarWidget(
              onQueryChanged: (q) => query = q,
              onClear: () => cleared = true,
            ),
          ),
        ),
      );

      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'Interstellar');
      await tester.pump(const Duration(milliseconds: 500));

      expect(query, equals('Interstellar'));

      final clearButton = find.byIcon(Icons.close);
      expect(clearButton, findsOneWidget);

      await tester.tap(clearButton);
      await tester.pump(const Duration(milliseconds: 500));

      expect(cleared, isTrue);
    });
  });
}
