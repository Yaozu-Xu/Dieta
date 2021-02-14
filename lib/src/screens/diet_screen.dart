import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/diet_model.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/diet_collection.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/widgets/cards/diet_card.dart';

class DietScreen extends StatelessWidget {
  static const String routeName = '/diet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Diet',
          ),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        bottomNavigationBar: const BottomButtons(1),
        body: FutureBuilder<DocumentSnapshot>(
          future: DietCollection.getLowCaloriesDiets(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> dietSnapshot) {
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
        ));
  }
}
