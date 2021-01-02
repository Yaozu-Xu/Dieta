import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/model/User.dart';
import 'package:fyp_dieta/src/redux/actions/user_action.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/screens/login_screen.dart';

class UserStreamBuilder extends StatefulWidget {
  final Widget buildedWidget;

  UserStreamBuilder({@required this.buildedWidget});

  @override
  _UserStreamBuilderState createState() => _UserStreamBuilderState();
}

class _UserStreamBuilderState extends State<UserStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }
            StoreProvider.of<AppState>(context)
                .dispatch(SetUserAction(UserState(
              user: UserFields.fromJson(user),
              isLogin: true,
            )));
            return widget.buildedWidget;
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
