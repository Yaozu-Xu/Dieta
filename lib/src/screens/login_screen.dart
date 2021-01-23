import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/screens/signup_screen.dart';
import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:fyp_dieta/src/widgets/buttons/signin_buttons.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_input.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _loginErrorMsg = '';
  bool _showLoginError = false;

  void _loginBtnPressed() async {
    if (this._formkey.currentState.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: this._email, password: this._password);
        Navigator.pushNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (err) {
        setState(() {
          this._showLoginError = true;
          this._loginErrorMsg = err.code;
        });
      }
    }
  }

  void _hideErrorMsg() {
    if(this._showLoginError) {
      setState(() {
        this._showLoginError = false;
        this._loginErrorMsg = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Form(
            key: _formkey,
            child: Column(children: [
              LoginInputDecration(
                placeHolder: 'Email',
                validator: Validator.emailValidator,
                onChanged: (value) {
                  this._hideErrorMsg();
                  setState(() {
                    this._email = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Password',
                obscureText: true,
                validator: Validator.passwordValidator,
                onChanged: (value) {
                  this._hideErrorMsg();
                  setState(() {
                    this._password = value;
                  });
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 30, right: 20),
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpScreen.routeName);
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
                    onPressed: this._loginBtnPressed,
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )),
              GoogleSignButtonPrimary(
                margin: EdgeInsets.only(top: 40),
              ),
              AnimatedOpacity(
                opacity: this._showLoginError ? 1 : 0,
                duration: Duration(milliseconds: 500),
                child: Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    color: Colors.grey[200],
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      this._loginErrorMsg,
                      style: TextStyle(color: Colors.red),
                    )),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
