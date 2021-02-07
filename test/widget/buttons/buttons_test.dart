import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/widgets/buttons/signin_buttons.dart';
import 'package:redux/redux.dart';

final store = Store<AppState>(appReducer, initialState: AppState.intital());

Widget createMockApp(Widget testedWidget) => MediaQuery(
    data: MediaQueryData(),
    child: StoreProvider(
        store: store, child: MaterialApp(home: testedWidget)));

void main() {
  group('Button widgets testing', () {
    testWidgets('Load BottomButtons', (WidgetTester tester) async {
      final String iconText = 'Diet';
      await tester.pumpWidget(createMockApp(BottomButtons(0)));
      final navigatorFinder = find.byType(BottomNavigationBar);
      final iconFinder = find.text(iconText);
      expect(navigatorFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('Load SigninButtons', (WidgetTester tester) async {
      final String buttonText = 'Sign in with Google';
      await tester.pumpWidget(createMockApp(GoogleSignButtonPrimary()));
      final buttonFinder = find.text(buttonText);
      expect(buttonFinder, findsOneWidget);
    });
  });
}
