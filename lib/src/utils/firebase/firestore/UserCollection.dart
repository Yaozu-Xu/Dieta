import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection {
  CollectionReference user = FirebaseFirestore.instance.collection('User');

  Future addUserSettings(String uid, Map data) async {
    return await user.doc(uid).set(data);
  }

  Future<DocumentSnapshot> getUserSettings({@required String uid}) async {
    return await user.doc(uid).get();
  }
}
