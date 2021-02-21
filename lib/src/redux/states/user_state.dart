import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/user_model.dart';

class UserState {
  UserState({this.user, this.isLogin, this.settings});

  factory UserState.initial() => UserState(isLogin: false);

  final UserFields user;
  final bool isLogin;
  final UserSettings settings;

  UserState copyWith({@required UserFields user, @required bool isLogin}) {
    return UserState(user: user ?? this.user, isLogin: isLogin ?? this.isLogin);
  }
}

class UserSettings {
  UserSettings(
      {@required this.age,
      @required this.height,
      @required this.sex,
      @required this.sportsLevel,
      @required this.totalCalories,
      @required this.weight,
      @required this.weightStaging});

  factory UserSettings.fromJson(Map<String, dynamic> settings) {
    return UserSettings(
      age: settings['age'] as int,
      height: settings['height'],
      sex: settings['sex'] as int,
      sportsLevel: settings['sportsLevel'] as int,
      totalCalories: settings['totalCalories'] as int,
      weight: settings['weight'],
      weightStaging: settings['weightStaging'] as int,
    );
  }

  final int age;
  final dynamic height;
  final int sex;
  final int sportsLevel;
  final int totalCalories;
  final dynamic weight;
  final int weightStaging;
}
