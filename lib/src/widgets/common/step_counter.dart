import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';

class StepCounter extends StatefulWidget {

  const StepCounter({@required this.uid});

  final String uid;

  
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  final double _factor = 0.04;
  int _currentCaloires = 0;
  Stream<StepCount> _stepCountStream;
  StreamSubscription<dynamic> _stepCountStreamSubscription;

  Future<void> onStepCount(StepCount event) async {
    /// Handle step count changed
    final int currentSteps = event.steps;
    final int steps = await getStepsByDate(
        key: genStepsStorageKey(uid: widget.uid),
        steps: currentSteps,
        uid: widget.uid);
    final int caloires = (steps * _factor).floor();
    if (caloires > _currentCaloires) {
      await setColoriesByDate(
          key: genCaloriesStorageKey(uid: widget.uid), calories: caloires);
      setState(() {
        _currentCaloires = caloires;
      });
    }
  }

  void onStepCountError(Object err) {
    setState(() {});
  }

  Future<void> initStream() async {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    final int calories =
        await getColoriesByDate(key: genStepsStorageKey(uid: widget.uid));
    setState(() {
      _currentCaloires = calories;
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
    if (_stepCountStreamSubscription != null) {
      _stepCountStreamSubscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Text>[
            Text(_currentCaloires.toString(), style: valueStyle),
            Text('Consume', style: labelStyle),
          ]),
    );
  }
}
