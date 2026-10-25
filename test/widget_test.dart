// Basic Flutter widget test for RestaurantMenuApp.
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_menu/main.dart';

void main() {
  testWidgets('Restaurant Menu screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RestaurantMenuApp());

    // Verify that the AppBar title 'Restaurant Menu' exists on screen.
    expect(find.text('Restaurant Menu'), findsOneWidget);

    // Verify that our traditional dishes are present on screen.
    expect(find.text('Nasi Lemak'), findsOneWidget);
    expect(find.text('Satay Ayam'), findsOneWidget);
  });
}