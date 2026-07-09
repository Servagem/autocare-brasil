import 'package:flutter_test/flutter_test.dart';
import 'package:autocare_brasil/app/app.dart';

void main() {
  testWidgets('App inicia corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const AutoCareApp());

    expect(find.text('AutoCare Brasil'), findsOneWidget);
  });
}