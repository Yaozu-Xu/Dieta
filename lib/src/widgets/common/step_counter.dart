import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';

class StepCounter extends StatefulWidget {
  final String uid;

  const StepCounter({@required this.uid});
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  final String key = DateTime.now().toString().substring(0, 10);
  
  final double _factor = 0.04;
  int _currentCaloires = 0;
  Stream<StepCount> _stepCountStream;
  StreamSubscription _stepCountStreamSubscription;

  void onStepCount(StepCount event) async {
    /// Handle step count changed
    print(key);
    int currentSteps = event.steps;
    int steps = await getTodaySteps(
        key: this.key, steps: currentSteps, uid: widget.uid);
    print('$key walks $steps steps');
    int caloires = (steps * _factor).floor();
    if (caloires > this._currentCaloires) {
      await setTodayColories(key: this.key, calories: caloires);
      setState(() {
        this._currentCaloires = caloires;
      });
    }
  }

  void onStepCountError(error) {
    setState(() {
      
    });
  }

  Future<void> initStream() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    int calories = await getTodayColories(key: this.key);
    setState(() {
      this._currentCaloires = calories;
    });
  }

  @override
  void initState() {
    super.initState();
    initStream();
  }

  @override
  void dispose() {
    super.dispose();
    if (this._stepCountStreamSubscription != null) {
      this._stepCountStreamSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(this._currentCaloires.toString(), style: valueStyle),
            Text('Consume', style: labelStyle),
          ]),
    );
  }
}
