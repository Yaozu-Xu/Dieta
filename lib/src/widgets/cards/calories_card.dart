import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/widgets/common/step_counter.dart';
import 'package:flutter/material.dart';

class CaloriesCard extends StatefulWidget {
  final int totalCalories;
  final int intake;
  final int suagr;
  final int protein;
  final int fat;
  final String uid;

  const CaloriesCard(
      {@required this.totalCalories,
      @required this.intake,
      @required this.uid,
      @required this.suagr,
      @required this.fat,
      @required this.protein});

  @override
  _CaloriesCardState createState() => _CaloriesCardState();
}

class _CaloriesCardState extends State<CaloriesCard> {
  final String leftColumnLabel = 'Intake';
  final brightPink = Color(0xffff6ba0);
  final brightOrange = Color(0xffffca28);
  final brightGreen = Color(0xff76ff03);

  String _leftColumnValue() {
    return widget.intake != null ? widget.intake.toString() : '0';
  }

  Widget _buildExpandedColumn(String label, String count) {
    return Expanded(
        child: Container(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count, style: valueStyle),
            Text(label, style: labelStyle),
          ]),
    ));
  }

  Widget _buildNutritionColumn(
      String label, String count, Color color, double value) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: labelStyle),
          Container(
              margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: LinearProgressIndicator(
                value: value,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation(color),
              )),
          Container(
              child: Text(
                count + 'g',
                style: valueStyle.copyWith(fontSize: 14),
              ),
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10))
        ]);
  }

  Widget _buildNutritionRow() {
    return Row(children: [
      Expanded(
        child: _buildNutritionColumn('Carb', widget.suagr.toString(), brightPink, .1),
      ),
      Expanded(child: _buildNutritionColumn('Protein', widget.protein.toString(), brightOrange, .2)),
      Expanded(child: _buildNutritionColumn('Fat', widget.fat.toString(), brightGreen, .4)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Wrap(
        children: [
          Row(children: [
            _buildExpandedColumn(leftColumnLabel, _leftColumnValue()),
            Container(
                child: Column(children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      constraints: BoxConstraints.tightForFinite(
                        height: 80,
                        width: 80,
                      ),
                      child: CircularProgressIndicator(
                        value: .8,
                        strokeWidth: 5,
                        backgroundColor: Colors.grey[300],
                        valueColor:
                            AlwaysStoppedAnimation(Colors.cyanAccent[100]),
                      )),
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.totalCalories.toString(),
                        style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )),
                ]),
                height: 200),
            Expanded(child: StepCounter(uid: widget.uid))
          ]),
          _buildNutritionRow(),
        ],
      ),
    );
  }
}
