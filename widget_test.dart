import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';

void main() {
  testWidgets('Weather app loads and UI elements are present', (WidgetTester tester) async {
    // Build the app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Verify if the app title is present
    expect(find.text('Weather App'), findsOneWidget);

    // Verify if the text field is present
    expect(find.byType(TextField), findsOneWidget);

    // Verify if the button is present
    expect(find.byType(ElevatedButton), findsOneWidget);

    // Verify if the button text is correct
    expect(find.text('Get Weather'), findsOneWidget);

    // Verify if the placeholder city name is correct
    await tester.enterText(find.byType(TextField), 'London');
    expect(find.text('London'), findsOneWidget);
  });
}
