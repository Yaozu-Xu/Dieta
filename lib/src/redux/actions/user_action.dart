import 'package:fyp_dieta/src/redux/states/user_state.dart';

class SetUserAction {
  final UserState userState;
  SetUserAction(this.userState);

  @override
  String toString() {
    return 'set ' + userState.toString();
  }
}