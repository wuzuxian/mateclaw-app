import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mateclaw_app/app.dart';

void main() {
  testWidgets('shows login page', (tester) async {
    await tester.pumpWidget(const MateclawApp());

    expect(find.byType(MateclawApp), findsOneWidget);
    expect(find.text('Mate'), findsOneWidget);
    expect(find.text('Claw'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.byType(FilledButton), findsOneWidget);
  });
}
