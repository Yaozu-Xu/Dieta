import 'package:flutter/material.dart';

class AnimatedErrorMsg extends StatelessWidget {
  final bool showError;
  final String errMag;

  AnimatedErrorMsg({@required this.showError, @required this.errMag});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: this.showError ? 1 : 0,
      duration: Duration(milliseconds: 500),
      child: Container(
          margin: EdgeInsets.only(top: 40),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          color: Colors.grey[200],
          constraints: BoxConstraints(maxWidth: 200),
          child: Text(
            this.errMag,
            style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold),
          )),
    );
  }
}
