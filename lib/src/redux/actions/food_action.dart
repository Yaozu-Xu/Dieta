import 'package:fyp_dieta/src/redux/states/food_state.dart';

class SetFoodAction {
  SetFoodAction(this.foodState);

  final FoodState foodState;

  @override
  String toString() {
    return 'set $foodState';
  }
}
