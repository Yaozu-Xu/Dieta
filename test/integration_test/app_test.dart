import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_input.dart';
import 'package:integration_test/integration_test.dart';
import 'package:fyp_dieta/main.dart' as app;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load();
  group('Login Screen', () {
    testWidgets('Fail at login with invalid email',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder loginInputs = find.byType(LoginInputDecration);
      final Finder btn = find.byType(OutlineButton);
      expect(loginInputs, findsWidgets);
      await tester.enterText(loginInputs.first, 'email');
      await tester.enterText(loginInputs.last, 'pwd');
      await tester.tap(btn);
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Email is invalid'), findsOneWidget);
    });

    testWidgets('Login with email and password', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      final Finder loginInputs = find.byType(LoginInputDecration);
      final Finder btn = find.byType(OutlineButton);
      final String testEmail = DotEnv().env['TEST_EMAIL'] ?? '';
      final String testPwd = DotEnv().env['TEST_PWD'] ?? '';
      await tester.enterText(loginInputs.first, testEmail);
      await tester.enterText(loginInputs.last, testPwd);
      await tester.tap(btn);
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text('Record'), findsOneWidget);
    });
  });
}
