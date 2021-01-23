import 'package:flutter/material.dart';

class CaloriesCalculator {
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

  CaloriesCalculator(
      {@required this.height,
      @required this.weight,
      @required this.age,
      @required this.sex,
      @required this.activityLevel,
      @required this.weightStaging});

  double calculateBMR() {
    if (this.sex == 0) {
      return 66.5 +
          (13.75 * this.weight) +
          (5.003 * this.height) -
          (6.755 * this.age);
    }
    return 655 +
        (9.563 * this.weight) +
        (1.850 * this.height) -
        (4.676 * this.age);
  }

  double getActivityFactor() {
    List<double> activityLevelList = [
      this.lightActivityLevel,
      this.moderateActivityLevel,
      this.activeActivityLevel
    ];
    return activityLevelList[this.activityLevel];
  }

  int loseWeighTotalEnergy() {
    return (calculateBMR() * this.getActivityFactor() -
            this.loseWeightEnergyFactor)
        .round();
  }

  int maintainWeighTotalEnergy() {
    return (calculateBMR() * this.getActivityFactor()).round();
  }

  int gainWeighTotalEnergy() {
    return (calculateBMR() * this.getActivityFactor() +
            this.gainWeightEnergyFactor)
        .round();
  }

  int calculateTotalEnergy() {
    switch (this.weightStaging) {
      case 0: {
        return this.loseWeighTotalEnergy();
      }
      break;
      case 1: {
        return this.maintainWeighTotalEnergy();
      }
      break;
      case 2: {
        return this.gainWeighTotalEnergy();
      }
      break;
      default: {
        return this.maintainWeighTotalEnergy();
      }
    }
  }
}
