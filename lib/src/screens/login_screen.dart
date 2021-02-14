import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/screens/signup_screen.dart';
import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:fyp_dieta/src/widgets/buttons/signin_buttons.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_input.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email;
  String _password;

  Future<void> _loginBtnPressed() async {
    if (_formkey.currentState.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.pushNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (err) {
        Toast.showFailedMsg(context: context, message: err.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Form(
            key: _formkey,
            child: Column(children: <Widget>[
              LoginInputDecration(
                placeHolder: 'Email',
                validator: Validator.emailValidator,
                onChanged: (String value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Password',
                obscureText: true,
                validator: Validator.passwordValidator,
                onChanged: (String value) {
                  setState(() {
                    _password = value;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 30, right: 20),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
                  },
                  child: const Text(
                    'Create an account here',
                    style: TextStyle(
                      color: Color(0xFF4285F4),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: _loginBtnPressed,
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )),
              const GoogleSignButtonPrimary(
                margin: EdgeInsets.only(top: 40),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
