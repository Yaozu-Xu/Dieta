import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/widgets/buttons/signin_buttons.dart';
import 'package:fyp_dieta/src/widgets/buttons/floating_buttons.dart';
import 'package:redux/redux.dart';

final Store<AppState> store =
    Store<AppState>(appReducer, initialState: AppState.intital());

Widget createMockApp(Widget testedWidget) => MediaQuery(
    data: const MediaQueryData(),
    child: StoreProvider<AppState>(
        store: store, child: MaterialApp(home: testedWidget)));

void main() {
  group('Button widgets testing', () {
    testWidgets('Load BottomButtons', (WidgetTester tester) async {
      const String iconText = 'Diet';
      await tester.pumpWidget(createMockApp(const BottomButtons(0)));
      final Finder navigatorFinder = find.byType(BottomNavigationBar);
      final Finder iconFinder = find.text(iconText);
      expect(navigatorFinder, findsOneWidget);
      expect(iconFinder, findsOneWidget);
    });

    testWidgets('Load SigninButtons', (WidgetTester tester) async {
      const String buttonText = 'Sign in with Google';
      await tester.pumpWidget(createMockApp(const GoogleSignButtonPrimary()));
      final Finder buttonFinder = find.text(buttonText);
      expect(buttonFinder, findsOneWidget);
    });

    testWidgets('Load FloatingButton', (WidgetTester tester) async {
      await tester
          .pumpWidget(createMockApp(const MealIconFloatingButton(mealType: 1)));
      final Finder floatBtnFinder = find.byIcon(Icons.kitchen);
      expect(floatBtnFinder, findsOneWidget);
    });
  });
}
