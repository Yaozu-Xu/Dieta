import 'package:fyp_dieta/src/redux/actions/food_action.dart';
import 'package:fyp_dieta/src/redux/states/food_state.dart';
import 'package:redux/redux.dart';

final foodReducer = combineReducers<FoodState>(
    [TypedReducer<FoodState, SetFoodAction>(_activeSetFoodAction)]);

FoodState _activeSetFoodAction(
    FoodState preState, SetFoodAction setFoodAction) {
  return setFoodAction.foodState;
}
