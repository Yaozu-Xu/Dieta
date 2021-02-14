import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/record_collection.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/user_collection.dart';
import 'package:fyp_dieta/src/widgets/cards/calories_card.dart';
import 'package:fyp_dieta/src/widgets/cards/weight_info_card.dart';
import 'package:fyp_dieta/src/widgets/cards/food_card.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:redux/redux.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<DocumentSnapshot> recordSnapshot;

  int suggestCalories({int index, int totalCalories}) {
    switch (index) {
      case 0:
        {
          return (totalCalories / 4 - 100).round();
        }
        break;
      case 1:
        {
          return (totalCalories / 4 + 100).round();
        }
        break;
      case 2:
        {
          return (totalCalories / 4 + 100).round();
        }
        break;
      case 3:
        {
          return (totalCalories / 4 - 100).round();
        }
        break;
      default:
        {
          return null;
        }
        break;
    }
  }

  int getCaloriesByType({dynamic data, int mealType}) {
    int calories = 0;
    if (data.containsKey('food') as bool) {
      data['food'].forEach((dynamic meal) {
        if (meal['mealType'] == mealType) {
          calories += meal['calories'] as int;
        }
      });
    }
    return calories;
  }

  Map<String, int> getNutrition({Map<String, dynamic> data}) {
    final Map<String, int> nutrition = <String, int>{
      'sugar': 0,
      'protein': 0,
      'fat': 0
    };
    if (data.containsKey('food')) {
      data['food'].forEach((dynamic meal) {
        nutrition['sugar'] += meal['suagrs'] as int;
        nutrition['protein'] += meal['protein'] as int;
        nutrition['fat'] += meal['fat'] as int;
      });
    }
    return nutrition;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        converter: (Store<AppState> store) => store.state.userState,
        builder: (BuildContext context, UserState userState) {
          final String uid = userState.user.uid;
          final Future<DocumentSnapshot> recordFuture =
              RecordCollection(uid: uid, date: currentDate)
                  .getAllRecordsByDate();
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Record',
                    style: TextStyle(
                        letterSpacing: 1.2,
                        color: Colors.grey[200].withOpacity(0.4))),
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                automaticallyImplyLeading: false,
              ),
              bottomNavigationBar: const BottomButtons(0),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).buttonColor,
                onPressed: () {
                  Navigator.pushNamed(context, FoodScreen.routeName,
                      arguments: FoodScreenArguments(mealType: 0));
                },
                child: const Icon(Icons.add),
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
              body: FutureBuilder<DocumentSnapshot>(
                  future: UserCollection().getUserSettings(uid: uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<dynamic> userSnapshot) {
                    if (userSnapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (userSnapshot.connectionState == ConnectionState.done &&
                        userSnapshot.data.data() != null) {
                      final Map<String, dynamic> data =
                          userSnapshot.data.data() as Map<String, dynamic>;
                      return FutureBuilder<DocumentSnapshot>(
                          future: recordFuture,
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> recordSnapshot) {
                            int sugar = 0;
                            int protein = 0;
                            int fat = 0;
                            int breakfastCalories = 0;
                            int lunchCalories = 0;
                            int dinnerCalories = 0;
                            int extraCalories = 0;
                            int intakeCalories = 0;
                            if (recordSnapshot.hasData &&
                                recordSnapshot.data.data() != null) {
                              final Map<String, dynamic> recordData =
                                  recordSnapshot.data.data()
                                      as Map<String, dynamic>;

                              breakfastCalories = getCaloriesByType(
                                  data: recordData, mealType: 0);
                              lunchCalories = getCaloriesByType(
                                  data: recordData, mealType: 1);
                              dinnerCalories = getCaloriesByType(
                                  data: recordData, mealType: 2);
                              extraCalories = getCaloriesByType(
                                  data: recordData, mealType: 3);
                              intakeCalories = breakfastCalories +
                                  lunchCalories +
                                  dinnerCalories +
                                  extraCalories;
                              final Map<String, int> nutrition =
                                  getNutrition(data: recordData);
                              sugar = nutrition['sugar'];
                              fat = nutrition['fat'];
                              protein = nutrition['protein'];
                            } else {}
                            return ListView(
                              children: <Widget>[
                                Column(children: <Widget>[
                                  CaloriesCard(
                                      totalCalories:
                                          data['totalCalories'] as int,
                                      intake: intakeCalories,
                                      suagr: sugar,
                                      protein: protein,
                                      fat: fat,
                                      uid: uid),
                                  WeightInfoCard(
                                    username: userState.user.displayName,
                                    uid: uid,
                                    weight: data['weight'],
                                    weightStaging: data['weightStaging'] as int,
                                  )
                                ]),
                                Row(
                                  children: <Widget>[
                                    FoodCard(
                                      labelIndex: 0,
                                      intakeCalories: breakfastCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 0,
                                        totalCalories:
                                            data['totalCalories'] as int,
                                      ),
                                    ),
                                    FoodCard(
                                      labelIndex: 1,
                                      intakeCalories: lunchCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 1,
                                        totalCalories:
                                            data['totalCalories'] as int,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <FoodCard>[
                                    FoodCard(
                                      labelIndex: 2,
                                      intakeCalories: dinnerCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 2,
                                        totalCalories:
                                            data['totalCalories'] as int,
                                      ),
                                    ),
                                    FoodCard(
                                      labelIndex: 3,
                                      intakeCalories: extraCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 3,
                                        totalCalories:
                                            data['totalCalories'] as int,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    }
                    return const Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }));
        });
  }
}
