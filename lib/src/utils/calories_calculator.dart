import 'package:flutter/material.dart';

class CaloriesCalculator {
  CaloriesCalculator(
      {@required this.height,
      @required this.weight,
      @required this.age,
      @required this.sex,
      @required this.activityLevel,
      @required this.weightStaging});

  final double lightActivityLevel = 1.53;
  final double moderateActivityLevel = 1.76;
  final double activeActivityLevel = 2.25;
  final int loseWeightEnergyFactor = 1000;
  final int gainWeightEnergyFactor = 500;
  final int weightStaging;
  final double height;
  final double weight;
  final int age;
  final int sex;
  final int activityLevel;

  double calculateBMR() {
    if (sex == 0) {
      return 66.5 +
          (13.75 * weight) +
          (5.003 * height) -
          (6.755 * age);
    }
    return 655 +
        (9.563 * weight) +
        (1.850 * height) -
        (4.676 * age);
  }

  double getActivityFactor() {
    final List<double> activityLevelList = <double>[
      lightActivityLevel,
      moderateActivityLevel,
      activeActivityLevel
    ];
    return activityLevelList[activityLevel];
  }

  int loseWeighTotalEnergy() {
    return (calculateBMR() * getActivityFactor() -
            loseWeightEnergyFactor)
        .round();
  }

  int maintainWeighTotalEnergy() {
    return (calculateBMR() * getActivityFactor()).round();
  }

  int gainWeighTotalEnergy() {
    return (calculateBMR() * getActivityFactor() +
            gainWeightEnergyFactor)
        .round();
  }

  int calculateTotalEnergy() {
    switch (weightStaging) {
      case 0:
        {
          return loseWeighTotalEnergy();
        }
        break;
      case 1:
        {
          return maintainWeighTotalEnergy();
        }
        break;
      case 2:
        {
          return gainWeighTotalEnergy();
        }
        break;
      default:
        {
          return maintainWeighTotalEnergy();
        }
    }
  }
}
