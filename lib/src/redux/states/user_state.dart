import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/User.dart';

class UserState{
  final UserFields user;
  final bool isLogin;

  UserState({this.user, this.isLogin});

  factory UserState.initial() => 
    UserState(user: null, isLogin: false);

  UserState copyWith({
    @required UserFields user,
    @required bool isLogin
  }) {
    return UserState(
      user: user ?? this.user,
      isLogin: isLogin ?? this.isLogin
    );
  }
}