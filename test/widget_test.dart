import 'package:flutter_test/flutter_test.dart';
import 'package:mateclaw_app/app.dart';

void main() {
  testWidgets('app starts', (tester) async {
    await tester.pumpWidget(const MateclawApp());

    expect(find.byType(MateclawApp), findsOneWidget);
  });
}
