import 'package:cloud_firestore/cloud_firestore.dart';

class DietCollection {
  static Future<DocumentSnapshot> getLowCaloriesDiets() async {
    return FirebaseFirestore.instance
        .collection('Diet')
        .doc('low-calories')
        .get();
  }
}
