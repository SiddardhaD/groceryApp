import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:grocery_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: GroceryApp(),
      ),
    );

    // Verify that the onboarding screen appears
    expect(find.text('Eat Your Way.\nAnytime.'), findsOneWidget);
  });
}
