import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/model/Food.dart';

class FoodState {
  final int total;
  final String search;
  final dynamic maxScore;
  final bool loaded;
  final List<FoodHits> hits;

  FoodState({this.search, this.total, this.maxScore, this.loaded, this.hits});

  factory FoodState.initial() =>
      FoodState(total: null, search: null, maxScore: null, loaded: false, hits: []);

  FoodState copyWith({
    @required int total,
    @required String search,
    @required dynamic maxScore,
    @required List<FoodHits> hits,
  }) {
    return FoodState(
        total: total ?? this.total,
        search: search ?? this.search,
        maxScore: maxScore ?? this.maxScore,
        loaded: loaded ?? this.loaded,
        hits: hits ?? this.hits);
  }
}
