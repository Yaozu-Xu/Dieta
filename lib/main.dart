import 'package:flutter/material.dart';
import './src/screens/record_screen.dart';
import './src/screens/diet_screen.dart';
import './src/screens/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorDark: Color(0xff37415E),
        cardColor: Color(0xff535D80),
        buttonColor:Color(0xffAF7DDE) ,
        bottomAppBarColor: Color(0xff252F4A),
        secondaryHeaderColor: Color(0xff252F4A),
      ),
      routes: {
        RecordScreen.routeName: (context) => RecordScreen(),
        DietScreen.routeName: (context) => DietScreen(),
        UserScreen.routeName: (context) => UserScreen(),
      },
    );
  }
}

