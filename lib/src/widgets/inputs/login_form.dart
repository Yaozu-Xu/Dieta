import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/widgets/layouts/login_form_decration.dart';
import 'package:fyp_dieta/src/widgets/buttons/signin_buttons.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Form(
        child: Column(children: [
          LoginInputDecration(
            placeHolder: 'Email',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          LoginInputDecration(
            placeHolder: 'Password',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 30, right: 20),
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: Text(
                'Create an account here',
                style: TextStyle(
                  color: Color(0xFF4285F4),
                ),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              width: MediaQuery.of(context).size.width,
              child: OutlineButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )),
          GoogleSignButton(
            margin: EdgeInsets.only(top: 40),
          )
        ]),
      ),
    );
  }
}
