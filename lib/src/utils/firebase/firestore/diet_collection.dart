import 'package:cloud_firestore/cloud_firestore.dart';

class DietCollection {
  static Future<DocumentSnapshot> getLowCaloriesDiets() async {
    return FirebaseFirestore.instance
        .collection('Diet')
        .doc('low-calories')
        .get();
  }

  static Future<DocumentSnapshot> getFitnessCaloriesDiets() async {
    return FirebaseFirestore.instance
        .collection('Diet')
        .doc('fitness-diets')
        .get();
  }

  static Future<DocumentSnapshot> getHealthyCaloriesDiets() async {
    return FirebaseFirestore.instance
        .collection('Diet')
        .doc('healthy-diets')
        .get();
  }
}
