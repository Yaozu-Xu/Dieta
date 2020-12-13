import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/widgets/layouts/login_form_decration.dart';

class SignUpScreen extends StatelessWidget {
  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignUp'),
        ),
        body: Container(
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
                  margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                    onPressed: () {},
                    child: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )),
            ]),
          ),
        ));
  }
}
