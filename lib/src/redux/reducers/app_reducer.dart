import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/reducers/food_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(foodState: foodReducer(state.foodState, action));
}
