import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecordCollection {
  final String uid;
  final String date;
  CollectionReference record;

  RecordCollection({@required this.uid, @required this.date}) {
    this.record = FirebaseFirestore.instance
        .collection('User')
        .doc(this.uid)
        .collection('Record');
  }

  Future<void> updateCaloriesRecord(Map data) async {
    DocumentSnapshot recordSnapthot = await record.doc(this.date).get();
    if (recordSnapthot.exists) {
      await record.doc(this.date).update(data);
    } else {
      await record.doc(this.date).set(data);
    }
  }

  Future<void> pushFoodRecord(Map data) async {
    DocumentSnapshot recordSnapthot = await record.doc(this.date).get();
    if (recordSnapthot.exists) {
      await record.doc(this.date).update({
        "food": FieldValue.arrayUnion([data])
      });
    } else {
      await record.doc(this.date).set({
        "food": [data]
      });
    }
  }

  Future<void> removeFoodRecord(Map data) async {
    DocumentSnapshot recordSnapthot = await record.doc(this.date).get();
    if (recordSnapthot.exists) {
      await record.doc(this.date).update({
        "food": FieldValue.arrayRemove([data])
      });
    } 
  }

  Future<QuerySnapshot> getAllRecords() async {
    return await record.get();
  }

  Future<DocumentSnapshot> getAllRecordsByDate() async {
    return await record.doc(this.date).get();
  }
}
