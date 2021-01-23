import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_input.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  String email;
  String username;
  String password;
  String _loginErrorMsg = '';
  bool _showLoginError = false;

  void _onPressed() async {
    if(!this._formkey.currentState.validate()) return null;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: this.email, password: this.password);
      await userCredential.user.updateProfile(displayName: this.username);
      Navigator.pushNamed(context, CollectionScreen.routeName,
          arguments: CollectionScreenArguments(
              implyLeading: false, uid: userCredential.user.uid));
    } on FirebaseAuthException catch (err) {
      setState(() {
        this._showLoginError = true;
        this._loginErrorMsg = err.code;
      });
    }
  }

  void _hideErrorMsg() {
    if (this._showLoginError) {
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
          title: Text('SignUp'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 30),
          child: Form(
            autovalidate: true,
            key: this._formkey,
            child: Column(children: [
              LoginInputDecration(
                placeHolder: 'Email',
                validator: Validator.emailValidator,
                onChanged: (value) {
                  this._hideErrorMsg();
                  setState(() {
                    this.email = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Usename',
                validator: Validator.usernameValidator,
                onChanged: (value) {
                  this._hideErrorMsg();
                  setState(() {
                    this.username = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Password',
                obscureText: true,
                validator: Validator.passwordValidator,
                onChanged: (value) {
                  setState(() {
                    this.password = value;
                  });
                },
              ),
              Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: _onPressed,
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )),
              Spacer(),
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
        ));
  }
}
