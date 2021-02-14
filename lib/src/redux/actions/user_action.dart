import 'package:fyp_dieta/src/redux/states/user_state.dart';

class SetUserAction {
  SetUserAction(this.userState);

  final UserState userState;

  @override
  String toString() {
    return 'set $userState';
  }
}
