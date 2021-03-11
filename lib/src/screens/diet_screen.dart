import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/model/diet_model.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/diet_collection.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/widgets/cards/diet_card.dart';
import 'package:fyp_dieta/src/widgets/layouts/linear_gradient.dart';
import 'package:redux/redux.dart';

class DietScreen extends StatelessWidget {
  static const String routeName = '/diet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Diet',
              style: appBarStyle),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: const BottomButtons(1),
        body: GradientContainer(
            child: StoreConnector<AppState, UserState>(
          converter: (Store<AppState> store) => store.state.userState,
          builder: (BuildContext context, UserState userState) {
            Future<DocumentSnapshot> future;
            final int flag = userState.settings.weightStaging;
            if (flag == 0) {
              future = DietCollection.getLowCaloriesDiets();
            } else if (flag == 1) {
              future = DietCollection.getHealthyCaloriesDiets();
            } else {
              future = DietCollection.getFitnessCaloriesDiets();
            }
            return FutureBuilder<DocumentSnapshot>(
              future: future,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> dietSnapshot) {
                if (dietSnapshot.hasData && dietSnapshot.data.data() != null) {
                  final List<dynamic> dietlList =
                      dietSnapshot.data.data()['diets'] as List<dynamic>;
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      final DietModel dietModel = DietModel.fromJson(
                          dietlList[index] as Map<String, dynamic>);
                      return DietCard(
                        photoUrl: dietModel.photoUrl,
                        name: dietModel.name,
                        link: dietModel.link,
                        description: dietModel.description,
                      );
                    },
                    itemCount: dietlList.length,
                  );
                }
                return const Scaffold(
                    body: Center(
                  child: CircularProgressIndicator(),
                ));
              },
            );
          },
        )));
  }
}
