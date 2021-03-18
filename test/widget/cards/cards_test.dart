import 'package:flutter_test/flutter_test.dart';
import 'package:fyp_dieta/src/widgets/cards/calories_card.dart';
import 'package:fyp_dieta/src/widgets/cards/food_card.dart';
import 'package:fyp_dieta/src/widgets/cards/weight_info_card.dart';
import '../../settings.dart';

void main() {
  group('Card widgets testing', () {
    testWidgets('Load Calories Card with correct labels', (WidgetTester tester) async {
      await tester.pumpWidget(createMockApp(const CaloriesCard(
          weightStaging: 0,
          totalCalories: 1000,
          intake: 100,
          uid: 'tester',
          suagr: 30,
          fat: 30,
          protein: 30)));
      final Finder carbLabel = find.text('Carb');
      final Finder proteinLabel = find.text('Protein');
      final Finder fatLabel = find.text('Fat');
      expect(carbLabel, findsOneWidget);
      expect(proteinLabel, findsOneWidget);
      expect(fatLabel, findsOneWidget);
    });

    testWidgets('Load Food Card with correct type', (WidgetTester tester) async {
       await tester.pumpWidget(createMockApp(const FoodCard(
         labelIndex: 0, intakeCalories: '100', suggestCaloires: '100')));
        final Finder breakfastCard = find.text('Breakfast');
        final Finder lunchCard = find.text('Lunch');
        expect(breakfastCard, findsOneWidget);
        expect(lunchCard, findsNothing);
    });

    testWidgets('Load WeightInfo Card with correct labels', (WidgetTester tester) async {
       await tester.pumpWidget(createMockApp(const WeightInfoCard(username: 'tester', uid: 'xxx', weightStaging: 0, weight: 65)));
        final Finder stagingLabel = find.text('Reduce');
        expect(stagingLabel, findsOneWidget);
    });
  });
}
