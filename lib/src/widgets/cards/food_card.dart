import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/screens/food_screen.dart';
import 'package:fyp_dieta/src/widgets/layouts/frosted_glass.dart';

class FoodCard extends StatefulWidget {
  const FoodCard(
      {@required this.labelIndex,
      @required this.intakeCalories,
      @required this.suggestCaloires});

  final int labelIndex;
  final dynamic intakeCalories;
  final dynamic suggestCaloires;

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  static const List<Icon> _iconList = <Icon>[
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
  static const List<String> _labelList = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Extra'
  ];

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
        height: 160,
        margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FoodScreen.routeName,
                  arguments: FoodScreenArguments(mealType: widget.labelIndex));
            },
            child: SizedBox(
                height: 160,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.only(right: 10, top: 10),
                      child: Text(_labelList[widget.labelIndex],
                          style: labelStyleBright),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 30),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: _iconList[widget.labelIndex],
                    ),
                    Expanded(
                        child: Column(children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 20, bottom: 5),
                        child: Text(
                          '${widget.intakeCalories} kcals',
                          style: valueStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 20),
                        child: Text('Suggest: ${widget.suggestCaloires}',
                            style: labelStyle.copyWith(fontSize: 12)),
                      ),
                    ]))
                  ],
                ))));
  }
}
