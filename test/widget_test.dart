// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nitoons/UI%20Actor/preferred_roles/preferred_roles_view.dart';

void main() {
  group('PreferredRoles', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(ProviderScope(
        child: MaterialApp(
          home: PreferredRoles(),
        ),
      ));

      expect(find.byType(PreferredRoles), findsOneWidget);
      // expect(find.text('Preferred roles'), findsOneWidget);
      // expect(find.byType(ListSelectContainer), findsNWidgets(14));
      // expect(find.byType(AppTextField), findsOneWidget);
      // expect(find.byType(AppButton), findsOneWidget);
    });

    testWidgets('selects and deselects tiles correctly', (tester) async {

    });

    testWidgets('saves on button press when a tile is selected',
        (tester) async {
      // Test save button behavior
    });

    testWidgets('disables save button when no tile is selected',
        (tester) async {
      // Test save button disabled state
    });
  });
}
