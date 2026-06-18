import 'package:flutter_test/flutter_test.dart';
import 'package:online_learning_app/main.dart';

void main() {
  testWidgets('shows onboarding screen on launch', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Numerous free\ntrial courses'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
  });
}
