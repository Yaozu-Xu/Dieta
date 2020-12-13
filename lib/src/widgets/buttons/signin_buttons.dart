import 'package:flutter/material.dart';

class SignInButtons extends StatelessWidget {
  final EdgeInsets margin;
  final String assets;

  SignInButtons({this.margin, @required this.assets});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RaisedButton(
          padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
          color: Color(0xFF4285F4),
          onPressed: () {},
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage(assets),
                height: 36,
              ),
              Container(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Text(
                    "Sign in with Google",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          )),
    );
  }
}

class GoogleSignButton extends SignInButtons {
  final EdgeInsets margin;
  final String assets = 'lib/src/assets/image/google.png';

  GoogleSignButton({this.margin, assets}): super(margin: margin, assets: assets);
}
