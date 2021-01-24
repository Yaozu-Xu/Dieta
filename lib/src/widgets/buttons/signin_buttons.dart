import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/utils/firebase/sign_in.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';

class GoogleSignInButton extends StatelessWidget {
  final EdgeInsets margin;
  final String assets;
  final int theme;

  GoogleSignInButton({this.margin, @required this.assets, this.theme});

  Widget primaryThemeButton(BuildContext context) {
    return RaisedButton(
        padding: EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
        color: Color(0xFF4285F4),
        onPressed: () async {
          String uid = await signInWithGoogle(); 
          if(uid != null ){
            // sign in successfully
            await initUserStorage(context, uid);
          }else {
            print('fail at login');
          }
        },
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
        ));
  }

  Widget lightThemeButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey[300]),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage(assets), height: 36.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    if (this.theme == 0) {
      return primaryThemeButton(context);
    } else if (this.theme == 1) {
      return lightThemeButton();
    } else {
      throw ('valid theme');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, child: signInButton(context));
  }
}

class GoogleSignButtonPrimary extends GoogleSignInButton {
  final EdgeInsets margin;
  final String assets = 'lib/src/assets/image/google.png';
  final int theme = 0;

  GoogleSignButtonPrimary({this.margin, assets, theme})
      : super(margin: margin, assets: assets, theme: theme);
}

class GoogleSignButtonLight extends GoogleSignInButton {
  final EdgeInsets margin;
  final String assets = 'lib/src/assets/image/google.png';
  final int theme = 1;

  GoogleSignButtonLight({this.margin, assets, theme})
      : super(margin: margin, assets: assets, theme: theme);
}
