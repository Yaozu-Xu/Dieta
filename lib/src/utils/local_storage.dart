import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/RecordCollection.dart';
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

Future<int> getTodaySteps(
    {@required String key, @required int steps, @required String uid}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int initialSteps = prefs.getInt('$key-steps');
  if (initialSteps == null) {
    prefs.setInt('$key-steps', steps);
    if (prefs.getString('today') != key) {
      // yesterday has records, upload yesterday records
      if (prefs.getString('today') != null) {
        await uploadYesterdayData(key: key, uid: uid, steps: steps);
      }
      prefs.setString('today', key);
    }
    return 0;
  }
  return steps - initialSteps;
}

Future<int> getTodayColories({@required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int calories = prefs.getInt('$key-caloriesFromSteps');
  if (calories == null) {
    prefs.setInt('$key-caloriesFromSteps', 0);
    return 0;
  }
  return calories;
}

Future<void> setTodayColories(
    {@required String key, @required int calories}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt('$key-caloriesFromSteps', calories);
}

Future<void> uploadYesterdayData(
    {@required uid, @required key, @required steps}) async {
  await RecordCollection(uid: uid, date: key).addNewRecords(
      <String, dynamic>{"steps": steps, "consume": await getTodayColories(key: key)});
}
