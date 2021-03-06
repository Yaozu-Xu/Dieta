import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/record_collection.dart';
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

// key: current date time
Future<int> getStepsByDate(
    {@required String key, @required int steps, @required String uid}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int initialSteps = prefs.getInt(key) ?? 0;
      
  if (initialSteps == 0) {
    prefs.setInt(key, steps);
    // date is note updated
    if (prefs.getString('today') != key) {
      final String keyOfYesterday = prefs.getString('today') ?? '';
      final  List<String> l = keyOfYesterday.split('-');
      final String dateKey = '${l[1]}-${l[2]}-${l[3]}';
      // upload yesterday data
      if (keyOfYesterday.isNotEmpty) {
        await uploadYesterdayData(date: dateKey, uid: uid, steps: steps);
      }
    }
    prefs.setString('today', key);
    return 0;
  }
  return steps - initialSteps;
}

Future<int> getColoriesByDate({@required String key}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final int calories = prefs.getInt(key) ?? 0;
  if (calories == 0) {
    prefs.setInt(key, 0);
    return 0;
  }
  return calories;
}

Future<void> setColoriesByDate(
    {@required String key, @required int calories}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, calories);
}

Future<void> uploadYesterdayData(
    {@required String uid, @required String date, @required int steps}) async {
  await RecordCollection(uid: uid, date: date)
      .updateCaloriesRecord(<String, dynamic>{
    'sports': <String, dynamic>{
      'steps': steps,
      'consume': await getColoriesByDate(key: date)
    }
  });
}

Future<void> setIosNotificationRights() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('ios-notification', true);
}

Future<void> setCurrentDate({@required String date}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('current-date', date);
}

Future<String> getCurrentDate() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('current-date');
}

Future<bool> hasIosNotificationRights() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('ios-notification') ?? false;
}

Future<bool> getDietNotifications() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diet-notifications') ?? true;
}

Future<bool> setDietNotifications({@required bool value}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setBool('diet-notifications', value);
}
