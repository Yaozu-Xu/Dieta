import 'package:fyp_dieta/src/redux/states/food_state.dart';

class SetFoodAction {
  final FoodState foodState;
  SetFoodAction(this.foodState);

  @override
  String toString() {
    return 'set ' + foodState.toString();
  }
}