import 'package:flutter/material.dart';

TextStyle labelStyle = TextStyle(
    color: Colors.white.withOpacity(0.4), fontWeight: FontWeight.bold);

TextStyle valueStyle = const TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);

TextStyle labelStyleBright = TextStyle(
  color: Colors.white.withOpacity(0.8),
  fontSize: 15,
  fontWeight: FontWeight.bold,
  letterSpacing: 1.2,
);

TextStyle appBarStyle =
    TextStyle(letterSpacing: 1.2, color: Colors.white.withOpacity(0.5));

TextStyle listLabelStyle = TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 18);

String currentDate = DateTime.now().toString().substring(0, 10);

String genCaloriesStorageKey({@required String uid}) {
  return '$uid-$currentDate-calories';
}

String genStepsStorageKey({@required String uid}) {
  return '$uid-$currentDate-steps';
}
