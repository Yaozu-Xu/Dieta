import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';

class FoodNavigatorBottons extends StatelessWidget {
  final int currentSection;
  final List mealLabelList = ['Breakfast', 'Lunch', 'Dinner', 'Extra'];

  FoodNavigatorBottons({@required this.currentSection});

  Widget _buildText(BuildContext context, int mealType) {
    Color textColor = Colors.grey[600];
    if (mealType == this.currentSection) {
      textColor = Colors.purple;
    }
    return Expanded(
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, FoodScreen.routeName,
                  arguments: FoodScreenArguments(mealType: mealType));
            },
            child: Container(
              child: Text(mealLabelList[mealType],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: textColor)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 40, right: 40, bottom: 5),
      child: Row(
        children: [
          _buildText(context, 0),
          _buildText(context, 1),
          _buildText(context, 2),
          _buildText(context, 3),
        ],
      ),
    );
  }
}
