import 'package:flutter/material.dart';
import '../../assets/constants.dart';

class FoodCard extends StatefulWidget {
  final int _labelIndex;
  final String _intakeCalories;
  final String _targetedCalories;

  const FoodCard(
      this._labelIndex, this._intakeCalories, this._targetedCalories);

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  static const _IconList = [
    Icon(
      Icons.free_breakfast,
      color: Colors.cyanAccent,
    ),
    Icon(
      Icons.kitchen,
      color: Color(0xffff6ba0),
    ),
    Icon(
      Icons.cake,
      color: Color(0xffffca28),
    ),
    Icon(
      Icons.fastfood,
      color: Color(0xff76ff03),
    ),
  ];

  static const _labelList = ['Breakfast', 'Lunch', 'Dinner', 'Extra'];
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Container(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 10, top: 10),
              child:
                  Text(_labelList[widget._labelIndex], style: mealLabelStyle),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 30),
              padding: EdgeInsets.all(4),
              child: _IconList[widget._labelIndex],
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300].withOpacity(0.4),
              ),
            ),
            Expanded(
                child: Container(
                    child: Column(children: [
              Container(
                child: Text(
                  widget._intakeCalories + ' kcals',
                  style: valueStyle.copyWith(fontSize: 14),
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, bottom: 5),
              ),
              Container(
                child: Text('Suggest: ' + widget._targetedCalories,
                    style: labelStyle.copyWith(fontSize: 12)),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20),
              ),
            ])))
          ],
        ),
        height: 160,
      ),
    ));
  }
}
