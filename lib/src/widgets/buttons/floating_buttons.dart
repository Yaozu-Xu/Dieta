import 'package:flutter/material.dart';

class MealIconFloatingButton extends StatelessWidget {
  const MealIconFloatingButton(
      {@required this.mealType, this.callback, this.uid});

  final int mealType;
  final Function callback;
  final String uid;

  IconData _buildMealIcon() {
    switch (mealType) {
      case 1:
        {
          return Icons.kitchen;
        }
        break;
      case 2:
        {
          return Icons.cake;
        }
        break;
      case 3:
        {
          return Icons.fastfood;
        }
        break;
      default:
        {
          return Icons.free_breakfast;
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).buttonColor,
      onPressed: () {
        Scaffold.of(context).openDrawer();
        callback(uid, mealType);
      },
      child: Icon(_buildMealIcon()),
    );
  }
}
