import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:fyp_dieta/src/screens/record_screen.dart';
import 'package:fyp_dieta/src/screens/diet_screen.dart';
import 'package:fyp_dieta/src/screens/user_screen.dart';
import 'package:fyp_dieta/src/screens/login_screen.dart';
import 'package:fyp_dieta/src/screens/signup_screen.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');
  final store = Store<AppState>(appReducer, initialState: AppState.intital());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: FutureBuilder(
            future: _firebaseApp,
            builder: (context, snapShot) {
              if (snapShot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                ); 
              } else if (snapShot.hasData) {
                // firebase load successfully
                return MaterialApp(
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
                    LoginScreen.routeName: (context) => LoginScreen(),
                    SignUpScreen.routeName: (context) => SignUpScreen(),
                    UserScreen.routeName: (context) => UserScreen(),
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
