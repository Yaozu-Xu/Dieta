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
  final double _factor = 0.04;
  int _currentCaloires = 0;
  Stream<StepCount> _stepCountStream;
  StreamSubscription _stepCountStreamSubscription;

  void onStepCount(StepCount event) async {
    /// Handle step count changed
    int currentSteps = event.steps;
    int steps = await getStepsByDate(
        key: genStepsStorageKey(uid: widget.uid),
        steps: currentSteps,
        uid: widget.uid);
    int caloires = (steps * _factor).floor();
    if (caloires > this._currentCaloires) {
      await setColoriesByDate(
          key: genCaloriesStorageKey(uid: widget.uid), calories: caloires);
      setState(() {
        this._currentCaloires = caloires;
      });
    }
  }

  void onStepCountError() {
    setState(() {});
  }

  Future<void> initStream() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    int calories =
        await getColoriesByDate(key: genStepsStorageKey(uid: widget.uid));
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
      _stepCountStreamSubscription.cancel();
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
