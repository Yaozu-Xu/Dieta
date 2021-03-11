import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            Color(0xff624ac3),
            Color(0xff6b4ec3),
            Color(0xff6c52b7),
            Color(0xff815ac3),
            Color(0xff9365c8),
            Color(0xffa770c9),
            Color(0xffb978c8)
          ])),
      child: child,
    );
  }
}
