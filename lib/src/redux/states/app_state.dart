import 'package:fyp_dieta/src/redux/states/food_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  const AppState({@required this.foodState, @required this.userState});

  factory AppState.intital() {
    return AppState(
        foodState: FoodState.initial(), userState: UserState.initial());
  }

  final FoodState foodState;
  final UserState userState;
}
