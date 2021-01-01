import 'package:fyp_dieta/src/redux/actions/user_action.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:redux/redux.dart';

final userReducer = combineReducers<UserState>([TypedReducer(_activeSetUserAction)]);

UserState _activeSetUserAction(
   UserState preState, SetUserAction setUserAction) {
  return setUserAction.userState;
}