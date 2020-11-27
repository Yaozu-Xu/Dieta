import 'package:fyp_dieta/src/redux/states/food_state.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final FoodState foodState;

  AppState({@required this.foodState});

  factory AppState.intital() {
    return AppState(foodState: FoodState.initial());
  }
}
