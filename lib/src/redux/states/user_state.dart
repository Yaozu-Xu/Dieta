import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/user_model.dart';

class UserState {
  UserState({this.user, this.isLogin});

  factory UserState.initial() => UserState(isLogin: false);

  final UserFields user;
  final bool isLogin;

  UserState copyWith({@required UserFields user, @required bool isLogin}) {
    return UserState(user: user ?? this.user, isLogin: isLogin ?? this.isLogin);
  }
}
