import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCollection {
  CollectionReference user = FirebaseFirestore.instance.collection('User');

  Future<void> addUserSettings(String uid, Map<String, dynamic> data) async {
    user.doc(uid).set(data);
  }

  Future<DocumentSnapshot> getUserSettings({@required String uid}) async {
    return user.doc(uid).get();
  }
}
