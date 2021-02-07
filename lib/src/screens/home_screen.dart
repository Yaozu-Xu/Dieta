import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/RecordCollection.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/UserCollection.dart';
import 'package:fyp_dieta/src/widgets/cards/calories_card.dart';
import 'package:fyp_dieta/src/widgets/cards/weight_info_card.dart';
import 'package:fyp_dieta/src/widgets/cards/food_card.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/';
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

  int getCaloriesByType({Map data, int mealType}) {
    int calories = 0;
    if (data.containsKey('food')) {
      data['food'].forEach((meal) => {
            if (meal['mealType'] == mealType) {calories += meal['calories']}
          });
    }
    return calories;
  }

  Map getNutrition({Map data}) {
    Map nutrition = {"sugar": 0, "protein": 0, "fat": 0};
    if (data.containsKey('food')) {
      data['food'].forEach((meal) => {
            nutrition["sugar"] += meal["suagrs"],
            nutrition["protein"] += meal["protein"],
            nutrition["fat"] += meal["fat"]
          });
    }
    return nutrition;
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UserState>(
        converter: (store) => store.state.userState,
        builder: (context, userState) {
          final uid = userState.user.uid;
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
              bottomNavigationBar: BottomButtons(0),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).buttonColor,
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, FoodScreen.routeName,
                      arguments: FoodScreenArguments(mealType: 0));
                },
              ),
              backgroundColor: Theme.of(context).primaryColorDark,
              body: FutureBuilder(
                  future: UserCollection().getUserSettings(uid: uid),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasError) {
                      return Text("Something went wrong");
                    }
                    if (userSnapshot.connectionState == ConnectionState.done &&
                        userSnapshot.data.data() != null) {
                      Map<String, dynamic> data = userSnapshot.data.data();
                      return FutureBuilder(
                          future: recordFuture,
                          builder: (context, recordSnapshot) {
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
                              Map recordData = recordSnapshot.data.data();

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
                              Map nutrition = getNutrition(data: recordData);
                              sugar = nutrition['sugar'];
                              fat = nutrition['fat'];
                              protein = nutrition['protein'];
                            } else {}
                            return ListView(
                              children: [
                                Column(children: [
                                  CaloriesCard(
                                      totalCalories: data['totalCalories'],
                                      intake: intakeCalories,
                                      suagr: sugar,
                                      protein: protein,
                                      fat: fat,
                                      uid: uid),
                                  WeightInfoCard(
                                    username: userState.user.displayName,
                                    uid: uid,
                                    weight: data['weight'],
                                    weightStaging: data['weightStaging'],
                                  )
                                ]),
                                Row(
                                  children: [
                                    FoodCard(
                                      labelIndex: 0,
                                      intakeCalories: breakfastCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 0,
                                        totalCalories: data['totalCalories'],
                                      ),
                                    ),
                                    FoodCard(
                                      labelIndex: 1,
                                      intakeCalories: lunchCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 1,
                                        totalCalories: data['totalCalories'],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    FoodCard(
                                      labelIndex: 2,
                                      intakeCalories: dinnerCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 2,
                                        totalCalories: data['totalCalories'],
                                      ),
                                    ),
                                    FoodCard(
                                      labelIndex: 3,
                                      intakeCalories: extraCalories,
                                      suggestCaloires: suggestCalories(
                                        index: 3,
                                        totalCalories: data['totalCalories'],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    }
                    return Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }));
        });
  }
}
