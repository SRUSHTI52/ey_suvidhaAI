import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:suvidha_ai_app/main.dart'; // <-- Adjust if your package name differs

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Optimization test successful!', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    // Wait for app to build
    await tester.pumpAndSettle();

    // Validate presence of welcome banner (Dashboard)
    expect(find.text('Welcome Back, John!'), findsOneWidget);

    // Tap the QR icon if needed
    // await tester.tap(find.byKey(ValueKey('qr_scanner_button')));
    // await tester.pumpAndSettle();

    // Add more interaction checks if needed...

    print('Optimization test successful!');
  });
}
