import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/model/user_model.dart';
import 'package:fyp_dieta/src/redux/actions/user_action.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/screens/login_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/user_collection.dart';

class UserStreamBuilder extends StatefulWidget {
  const UserStreamBuilder({@required this.buildedWidget});
  final Widget buildedWidget;

  @override
  _UserStreamBuilderState createState() => _UserStreamBuilderState();
}

class _UserStreamBuilderState extends State<UserStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }
            UserCollection()
                .getUserSettings(uid: user.uid)
                .then((DocumentSnapshot userSettingsSnapshot) {
              final Map<String, dynamic> settings = userSettingsSnapshot.data();
              StoreProvider.of<AppState>(context).dispatch(SetUserAction(
                  UserState(
                      user: UserFields.fromJson(user),
                      isLogin: true,
                      settings: UserSettings.fromJson(settings))));
            });
            return widget.buildedWidget;
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
