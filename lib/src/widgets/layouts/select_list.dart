import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/model/food_model.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/record_collection.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';

class SelectList extends StatelessWidget {
  const SelectList(
      {@required this.foodResponse,
      @required this.uid,
      @required this.mealType});

  final Future<FoodResponse> foodResponse;
  final String uid;
  final int mealType;

  ///
  String caloriesToolTipMessage(FoodFields foodFields) {
    return 'protein ${foodFields.nfProtein}g\nsugar ${foodFields.nfSugars}g\nfat ${foodFields.nfTotalFat}g';
  }

  Widget _buildFutureListView() {
    return FutureBuilder<FoodResponse>(
        future: foodResponse,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
          Widget renderedList;
          if (snapShot.hasData) {
            if (snapShot.data.total == 0) {
              renderedList = const Text('no result');
            } else {
              final List<FoodHits> _hitsList =
                  snapShot.data.hits as List<FoodHits>;
              renderedList = ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  final FoodHits _hits = _hitsList[index];
                  final FoodFields foodFields = _hits.fields;
                  return Row(
                    children: <Widget>[
                      Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          margin: const EdgeInsets.only(
                              left: 30, bottom: 10, top: 20),
                          child: Tooltip(
                              message: foodFields.itemName,
                              height: 24,
                              child: Text(foodFields.itemName,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)))),
                      Expanded(
                          child: Tooltip(
                              message: caloriesToolTipMessage(foodFields),
                              child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  child: Text(
                                    '${foodFields.nfCalories.round()}kcals',
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )))),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          tooltip: 'Add to record',
                          onPressed: () async {
                            final int calories =
                                foodFields.nfCalories.round() as int;
                            final int protein =
                                foodFields.nfProtein.round() as int;
                            final int fat =
                                foodFields.nfTotalFat.round() as int;
                            final int suagrs =
                                foodFields.nfSugars.round() as int;
                            try {
                              await RecordCollection(
                                      uid: uid, date: currentDate)
                                  .pushFoodRecord(<String, dynamic>{
                                'calories': calories,
                                'protein': protein,
                                'fat': fat,
                                'suagrs': suagrs,
                                'itemName': foodFields.itemName,
                                'mealType': mealType,
                                'id': DateTime.now().millisecondsSinceEpoch
                              });
                              Toast.showSuccessMsg(
                                  context: context, message: 'success');
                            } catch (error) {
                              Toast.showFailedMsg(
                                  context: context, message: 'failed');
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
                itemCount: _hitsList.length,
              );
            }
          } else if (snapShot.hasError) {
            developer.log('error${snapShot.error}');
            renderedList = const Text('Search text invalid');
          } else {
            // is loading
            developer.log('loading');
            renderedList =
                Text('loading', style: labelStyle.copyWith(fontSize: 16));
          }
          return renderedList;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildFutureListView());
  }
}
