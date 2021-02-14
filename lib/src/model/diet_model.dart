import 'package:flutter/material.dart';

class DietModel {
  DietModel(
      {@required this.description,
      @required this.name,
      @required this.link,
      @required this.photoUrl});

  factory DietModel.fromJson(Map<String, dynamic> json) {
    return DietModel(
      description: json['description'] as String,
      name: json['name'] as String,
      link: json['link'] as String,
      photoUrl: json['photoUrl'] as String,
    );
  }

  final String photoUrl;
  final String name;
  final String description;
  final String link;
}
