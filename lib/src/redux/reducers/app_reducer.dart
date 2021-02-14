import 'package:fyp_dieta/src/redux/reducers/user_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/reducers/food_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      foodState: foodReducer(state.foodState, action),
      userState: userReducer(state.userState, action));
}
