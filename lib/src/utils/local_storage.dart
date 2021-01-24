import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initUserStorage(BuildContext context, String uid) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // change to username
  final bool newUser = prefs.getBool(uid) ?? true;
  if (newUser) {
    Navigator.pushNamed(context, CollectionScreen.routeName,
        arguments: CollectionScreenArguments(implyLeading: false, uid: uid));
  } else {
    Navigator.pushNamed(context, HomeScreen.routeName);
  }
}
