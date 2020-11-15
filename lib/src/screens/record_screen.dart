import 'package:flutter/material.dart';
import '../widgets/cards/calories_card.dart';
import '../widgets/cards/weight_info_card.dart';
import '../widgets/cards/food_card.dart';
import '../widgets/buttons/bottom_buttons.dart';

class RecordScreen extends StatelessWidget {
  static const routeName = '/';
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
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
        body: ListView(
          children: [
            Column(children: [CaloriesCard(), WeightInfoCard()]),
            Row(
              children: [
                FoodCard(0, '200', '300'),
                FoodCard(1, '200', '300'),
              ],
            ),
            Row(
              children: [
                FoodCard(2, '200', '300'),
                FoodCard(3, '200', '300'),
              ],
            )
          ],
        ));
  }
}
