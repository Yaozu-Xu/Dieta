import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/screens/history_screen.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';
import 'package:redux/redux.dart';
import 'package:fyp_dieta/src/utils/notification.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';
import 'package:fyp_dieta/src/screens/diet_screen.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/screens/login_screen.dart';
import 'package:fyp_dieta/src/screens/signup_screen.dart';
import 'package:fyp_dieta/src/screens/user_screen.dart';
import 'package:fyp_dieta/src/widgets/layouts/user_stream_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load();
  final Store<AppState> store =
      Store<AppState>(appReducer, initialState: AppState.intital());
  await Notifications.loadNotification();
  await initTimeStamp();
  runApp(Dieta(store: store));
}

Future<void> initTimeStamp() async {
  if(await getCurrentDate() != currentDate){
    setCurrentDate(date: currentDate);
  }
}

class Dieta extends StatelessWidget {
  Dieta({Key key, this.store}) : super(key: key);

  final Store<AppState> store;
  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: FutureBuilder<FirebaseApp>(
            future: _firebaseApp,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseApp> snapShot) {
              if (snapShot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapShot.hasData) {
                // firebase load successfully
                return MaterialApp(
                  title: 'Dieta',
                  theme: ThemeData(
                    primaryColorDark: const Color(0xff37415E),
                    primaryColorLight: const Color(0xff6BEEAA),
                    buttonColor: const Color(0xffAF7DDE),
                    bottomAppBarColor: const Color(0xffb978c8),
                    secondaryHeaderColor: const Color(0xff624ac3),
                  ),
                  routes: <String, WidgetBuilder>{
                    HomeScreen.routeName: (BuildContext context) =>
                        UserStreamBuilder(buildedWidget: HomeScreen()),
                    CollectionScreen.routeName: (BuildContext context) =>
                        CollectionScreen(),
                    FoodScreen.routeName: (BuildContext context) =>
                        FoodScreen(),
                    DietScreen.routeName: (BuildContext context) =>
                        DietScreen(),
                    LoginScreen.routeName: (BuildContext context) =>
                        LoginScreen(),
                    SignUpScreen.routeName: (BuildContext context) =>
                        SignUpScreen(),
                    UserScreen.routeName: (BuildContext context) =>
                        UserScreen(),
                    HistoryScreen.routeName: (BuildContext context) =>
                        HistoryScreen()
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
