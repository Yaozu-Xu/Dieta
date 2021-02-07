import 'package:flutter/material.dart';

class MealIconFloatingButton extends StatelessWidget {
  final int mealType;
  final Function callback;
  final String uid;

  MealIconFloatingButton({@required this.mealType, this.callback, this.uid});

  IconData _buildMealIcon() {
    switch(mealType) {
      case 1: {
        return Icons.kitchen;
      }
      break;
      case 2: {
        return Icons.cake;
      }
      break;
      case 3: {
        return Icons.fastfood;
      }
      break;
      default: {
        return Icons.free_breakfast;
      }
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
     return FloatingActionButton(
      backgroundColor: Theme.of(context).buttonColor,
      child: Icon(_buildMealIcon()),
      onPressed: () {
        Scaffold.of(context).openDrawer();
        callback(uid, mealType);
      },
    );
  }
}
