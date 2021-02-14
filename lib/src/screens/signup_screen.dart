import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';
import 'package:fyp_dieta/src/widgets/inputs/login_input.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String email;
  String username;
  String password;

  Future<void> _onPressed() async {
    if (!_formkey.currentState.validate()) return;
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user.updateProfile(displayName: username);
      Navigator.pushNamed(context, CollectionScreen.routeName,
          arguments: CollectionScreenArguments(
              implyLeading: false, uid: userCredential.user.uid));
    } on FirebaseAuthException catch (err) {
      Toast.showFailedMsg(context: context, message: err.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 30),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formkey,
            child: Column(children: <Widget>[
              LoginInputDecration(
                placeHolder: 'Email',
                validator: Validator.emailValidator,
                onChanged: (String value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Usename',
                validator:
                    Validator.usernameValidator,
                onChanged: (String value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
              LoginInputDecration(
                placeHolder: 'Password',
                obscureText: true,
                validator:
                    Validator.passwordValidator,
                onChanged: (String value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: _onPressed,
                    child: const Text(
                      'SignUp',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )),
             const Spacer(),
            ]),
          ),
        ));
  }
}
