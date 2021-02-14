import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordCollection {
  RecordCollection({@required this.uid, @required this.date}) {
    record = FirebaseFirestore.instance
        .collection('User')
        .doc(uid)
        .collection('Record');
  }

  final String uid;
  final String date;
  CollectionReference record;

  Future<void> updateCaloriesRecord(Map<String, dynamic> data) async {
    final DocumentSnapshot recordSnapthot = await record.doc(date).get();
    if (recordSnapthot.exists) {
      await record.doc(date).update(data);
    } else {
      await record.doc(date).set(data);
    }
  }

  Future<void> pushFoodRecord(Map<String, dynamic> data) async {
    final DocumentSnapshot recordSnapthot = await record.doc(date).get();
    if (recordSnapthot.exists) {
      await record.doc(date).update(<String, dynamic>{
        'food': FieldValue.arrayUnion(<dynamic>[data])
      });
    } else {
      await record.doc(date).set(<String, dynamic>{
        'food': <dynamic>[data]
      });
    }
  }

  Future<void> removeFoodRecord(Map<String, dynamic> data) async {
    final DocumentSnapshot recordSnapthot = await record.doc(date).get();
    if (recordSnapthot.exists) {
      await record.doc(date).update(<String, dynamic>{
        'food': FieldValue.arrayRemove(<Map<String, dynamic>>[data])
      });
    }
  }

  Future<QuerySnapshot> getAllRecords() async {
    return record.get();
  }

  Future<DocumentSnapshot> getAllRecordsByDate() async {
    return record.doc(date).get();
  }
}
