import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/food_model.dart';

class FoodState {
  FoodState({this.search, this.total, this.maxScore, this.loaded, this.hits});

  factory FoodState.initial() => FoodState(loaded: false, hits: <FoodHits>[]);

  final int total;
  final String search;
  final dynamic maxScore;
  final bool loaded;
  final List<FoodHits> hits;

  FoodState copyWith({
    @required int total,
    @required String search,
    @required dynamic maxScore,
    @required List<FoodHits> hits,
  }) {
    return FoodState(
        total: total ?? total,
        search: search ?? search,
        maxScore: maxScore ?? maxScore,
        loaded: loaded ?? loaded,
        hits: hits ?? hits);
  }
}
