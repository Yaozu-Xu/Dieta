import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/widgets/common/step_counter.dart';
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/widgets/layouts/frosted_glass.dart';

class CaloriesCard extends StatefulWidget {
  const CaloriesCard(
      {@required this.totalCalories,
      @required this.intake,
      @required this.uid,
      @required this.suagr,
      @required this.fat,
      @required this.weightStaging,
      @required this.consume,
      @required this.protein});

  final int totalCalories;
  final int weightStaging;
  final int consume;
  final int intake;
  final int suagr;
  final int protein;
  final int fat;
  final String uid;

  @override
  _CaloriesCardState createState() => _CaloriesCardState();
}

class Protion {
  const Protion(
      {@required this.carb, @required this.protein, @required this.fat});
  final double carb;
  final double protein;
  final double fat;
}

class _CaloriesCardState extends State<CaloriesCard> {
  final String leftColumnLabel = 'Intake';
  final Color brightPink = const Color(0xffff6ba0);
  final Color brightOrange = const Color(0xffffca28);
  final Color brightGreen = const Color(0xff76ff03);
  final List<Protion> protionList = <Protion>[
    const Protion(carb: 0.45, protein: 0.3, fat: 0.25),
    const Protion(carb: 0.55, protein: 0.15, fat: 0.3),
    const Protion(carb: 0.6, protein: 0.2, fat: 0.2),
  ];

  String _leftColumnValue() {
    return widget.intake != null ? widget.intake.toString() : '0';
  }

  Widget _buildExpandedColumn(String label, String count) {
    return Expanded(
        child: SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(count, style: valueStyle),
            Text(label, style: labelStyle),
          ]),
    ));
  }

  Widget _buildNutritionColumn(
      String label, String count, Color color, double value) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(label, style: labelStyle),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              )),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Text(
              '${count}g',
              style: valueStyle.copyWith(fontSize: 14),
            ),
          )
        ]);
  }

  Widget _buildNutritionRow() {
    final Protion protion = protionList[widget.weightStaging];
    final double totalCarb = protion.carb * widget.totalCalories / 4;
    final double totalProtein = protion.protein * widget.totalCalories / 4;
    final double totalFat = protion.fat * widget.totalCalories / 9;
    return Row(children: <Widget>[
      Expanded(
        child: _buildNutritionColumn('Carb', widget.suagr.toString(),
            brightPink, progressBarValue(widget.suagr / totalCarb)),
      ),
      Expanded(
          child: _buildNutritionColumn('Protein', widget.protein.toString(),
              brightOrange, progressBarValue(widget.protein / totalProtein))),
      Expanded(
          child: _buildNutritionColumn('Fat', widget.fat.toString(),
              brightGreen, progressBarValue(widget.fat / totalFat))),
    ]);
  }

  double progressBarValue(double v) {
    if (v == 0) {
      return .1;
    }
    return v;
  }

  Widget _consumeContainer() {
    print(widget.consume);
    if (widget.consume != 0) {
      return SizedBox(
        height: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Text>[
              Text(widget.consume.toString(), style: valueStyle),
              Text('Consume', style: labelStyle),
            ]),
      );
    } else {
      return StepCounter(uid: widget.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FrostedGlass(
      height: 270,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Wrap(
        children: <Widget>[
          Row(children: <Widget>[
            _buildExpandedColumn(leftColumnLabel, _leftColumnValue()),
            SizedBox(
              height: 200,
              child: Column(children: <Widget>[
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    constraints: const BoxConstraints.tightForFinite(
                      height: 80,
                      width: 80,
                    ),
                    child: CircularProgressIndicator(
                      value: widget.intake / widget.totalCalories,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.cyanAccent[100]),
                    )),
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      widget.totalCalories.toString(),
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )),
              ]),
            ),
            Expanded(child: _consumeContainer())
          ]),
          _buildNutritionRow(),
        ],
      ),
    );
  }
}
