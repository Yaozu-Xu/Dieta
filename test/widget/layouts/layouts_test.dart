import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_dieta/src/model/food_model.dart';
import 'package:fyp_dieta/src/widgets/layouts/frosted_glass.dart';
import 'package:fyp_dieta/src/widgets/layouts/linear_gradient.dart';
import 'package:fyp_dieta/src/widgets/layouts/select_list.dart';
import '../../settings.dart';

void main() {

  group('Layout widgets testing', () {
    testWidgets('Load Linear Gradient Background', (WidgetTester tester) async {
      const GradientContainer gradientContainer = GradientContainer(
        child: SizedBox(
          width: 300,
          height: 300,
        ),
      );
      await tester.pumpWidget(createMockApp(gradientContainer));
      final Finder child = find.byType(SizedBox);
      expect(child, findsOneWidget);
      expect((gradientContainer.child as SizedBox).width, 300.0);
    });

    testWidgets('Load Frosted Glass Container', (WidgetTester tester) async {

      const FrostedGlass frostedGlass = FrostedGlass(
        height: 300,
        child: SizedBox(
          width: 300,
          height: 300,
        ),
      );
      await tester.pumpWidget(createMockApp(frostedGlass));
      final Finder child = find.byType(SizedBox);
      expect(child, findsOneWidget);
      expect(frostedGlass.height, 300);
    });

    testWidgets('Load Frosted Glass Container', (WidgetTester tester) async {
      Future<FoodResponse> mockFetch() async {
        return FoodResponse();
      }

      final SelectList selectList = SelectList(
        mealType: 0,
        uid: 'FAKE UID',
        foodResponse: mockFetch(),
      );
      await tester.pumpWidget(createMockApp(selectList));
      final Finder child = find.byWidget(selectList);
      expect(child, findsOneWidget);
    });
  });
}
