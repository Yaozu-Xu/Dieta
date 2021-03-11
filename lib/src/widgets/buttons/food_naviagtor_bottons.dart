import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';

class FoodNavigatorBottons extends StatelessWidget {
  FoodNavigatorBottons({@required this.currentSection});
  final int currentSection;
  final List<String> mealLabelList = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Extra'
  ];

  Widget _buildText(BuildContext context, int mealType) {
    Color textColor = Colors.white.withOpacity(0.4);
    FontWeight weight = FontWeight.normal;
    if (mealType == currentSection) {
      textColor = Colors.white.withOpacity(0.8);
      weight = FontWeight.bold;
    }
    return Expanded(
        child: InkWell(
      onTap: () {
        Navigator.pushNamed(context, FoodScreen.routeName,
            arguments: FoodScreenArguments(mealType: mealType));
      },
      child: Text(mealLabelList[mealType],
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: textColor, fontWeight: weight)),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 40, right: 40, bottom: 5),
      child: Row(
        children: <Widget>[
          _buildText(context, 0),
          _buildText(context, 1),
          _buildText(context, 2),
          _buildText(context, 3),
        ],
      ),
    );
  }
}
