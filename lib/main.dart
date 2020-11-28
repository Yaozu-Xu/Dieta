import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fyp_dieta/src/screens/record_screen.dart';
import 'package:fyp_dieta/src/screens/diet_screen.dart';
import 'package:fyp_dieta/src/screens/user_screen.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';

Future main() async {
  await DotEnv().load('.env');
  final store = Store<AppState>(appReducer, initialState: AppState.intital());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColorDark: Color(0xff37415E),
          cardColor: Color(0xff535D80),
          buttonColor: Color(0xffAF7DDE),
          bottomAppBarColor: Color(0xff252F4A),
          secondaryHeaderColor: Color(0xff252F4A),
        ),
        routes: {
          RecordScreen.routeName: (context) => RecordScreen(),
          FoodScreen.routeName: (context) => FoodScreen(),
          DietScreen.routeName: (context) => DietScreen(),
          UserScreen.routeName: (context) => UserScreen(),
        },
      ),
    );
  }
}
