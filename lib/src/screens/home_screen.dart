import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/UserCollection.dart';
import 'package:fyp_dieta/src/widgets/cards/calories_card.dart';
import 'package:fyp_dieta/src/widgets/cards/weight_info_card.dart';
import 'package:fyp_dieta/src/widgets/cards/food_card.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
            Navigator.pushNamed(context, '/food');
          },
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        body: StoreConnector<AppState, UserState>(
            converter: (store) => store.state.userState,
            builder: (context, userState) {
              final uid = userState.user.uid;
              return FutureBuilder(
                  future: UserCollection().getUserSettings(uid: uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.done && snapshot.data.data() != null) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return ListView(
                        children: [
                          Column(children: [
                            CaloriesCard(totalCalories: data['totalCalories']),
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
                                intakeCalories: 0,
                                suggestCaloires: suggestCalories(
                                  index: 0,
                                  totalCalories: data['totalCalories'],
                                ),
                              ),
                               FoodCard(
                                labelIndex: 1,
                                intakeCalories: 0,
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
                                intakeCalories: 0,
                                suggestCaloires: suggestCalories(
                                  index: 2,
                                  totalCalories: data['totalCalories'],
                                ),
                              ),
                               FoodCard(
                                labelIndex: 3,
                                intakeCalories: 0,
                                suggestCaloires: suggestCalories(
                                  index: 3,
                                  totalCalories: data['totalCalories'],
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }
                    return Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  });
            }));
  }
}
