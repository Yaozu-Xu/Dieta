import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(children: [
        LoginForm()
      ]),
    );
  }
}
