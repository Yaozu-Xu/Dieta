import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/utils/firebase/sign_in.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton(
      {@required this.margin, @required this.assets, @required this.theme});

  final EdgeInsets margin;
  final String assets;
  final int theme;

  Widget primaryThemeButton(BuildContext context) {
    return RaisedButton(
        padding: const EdgeInsets.only(top: 3.0, bottom: 3.0, left: 3.0),
        color: const Color(0xFF4285F4),
        onPressed: () async {
          final String uid = await signInWithGoogle();
          if (uid != null) {
            // sign in successfully
            await initUserStorage(context, uid);
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
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: const Text(
                  'Sign in with Google',
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
            const Padding(
              padding: EdgeInsets.only(left: 10),
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
    if (theme == 0) {
      return primaryThemeButton(context);
    } else if (theme == 1) {
      return lightThemeButton();
    } else {
      throw 'valid theme';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(margin: margin, child: signInButton(context));
  }
}

class GoogleSignButtonPrimary extends GoogleSignInButton {
  const GoogleSignButtonPrimary({EdgeInsets margin})
      : super(
            margin: margin,
            assets: 'lib/src/assets/image/google.png',
            theme: 0);
}

class GoogleSignButtonLight extends GoogleSignInButton {
  const GoogleSignButtonLight({EdgeInsets margin})
      : super(
            margin: margin,
            assets: 'lib/src/assets/image/google.png',
            theme: 1);
}
