import 'package:flutter/material.dart';

TextStyle labelStyle = TextStyle(
    color: Colors.grey[300].withOpacity(0.4), fontWeight: FontWeight.bold);
TextStyle valueStyle = TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[300]);
TextStyle mealLabelStyle = TextStyle(
  color: Colors.grey[300],
  fontSize: 15,
  letterSpacing: 1.2,
);
TextStyle listLabelStyle = TextStyle(color: Colors.grey[300], fontSize: 18);

String currentDate = DateTime.now().toString().substring(0, 10);

String genCaloriesStorageKey({@required uid}) {
  return '$uid-$currentDate-calories';
}

String genStepsStorageKey({@required uid}) {
  return '$uid-$currentDate-steps';
}
