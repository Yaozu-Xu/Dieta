import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'dart:developer' as developer;
import 'package:fyp_dieta/src/model/Food.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/RecordCollection.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';

class SelectList extends StatelessWidget {
  final Future<FoodResponse> foodResponse;
  final String uid;
  final int mealType;
  const SelectList(
      {@required this.foodResponse,
      @required this.uid,
      @required this.mealType});

  String caloriesToolTipMessage(foodFields) {
    return 'protein ' +
        foodFields.nfProtein.toString() +
        'g' +
        '\n' +
        'sugar ' +
        foodFields.nfSugars.toString() +
        'g' +
        '\n' +
        'fat ' +
        foodFields.nfTotalFat.toString() +
        'g';
  }

  Widget _buildFutureListView() {
    return FutureBuilder(
        future: this.foodResponse,
        builder: (context, snapShot) {
          Widget renderedList;
          if (snapShot.hasData) {
            if (snapShot.data.total == 0) {
              renderedList = Text('no result');
            } else {
              List _hitsList = snapShot.data.hits;
              renderedList = ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  FoodHits _hits = _hitsList[index];
                  FoodFields foodFields = _hits.fields;
                  return Container(
                    child: Row(children: [
                      Container(
                          constraints: BoxConstraints(maxWidth: 200),
                          margin:
                              EdgeInsets.only(left: 30, bottom: 10, top: 20),
                          child: Tooltip(
                              message: foodFields.itemName,
                              height: 24,
                              child: Text(foodFields.itemName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)))),
                      Expanded(
                          child: Tooltip(
                              message: caloriesToolTipMessage(foodFields),
                              child: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    foodFields.nfCalories.round().toString() +
                                        'kcals',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )))),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          tooltip: 'Add to record',
                          onPressed: () async {
                            int calories = foodFields.nfCalories.round();
                            int protein = foodFields.nfProtein.round();
                            int fat = foodFields.nfTotalFat.round();
                            int suagrs = foodFields.nfSugars.round();
                            try {
                              await RecordCollection(
                                      uid: this.uid, date: currentDate)
                                  .pushFoodRecord(<String, dynamic>{
                                "calories": calories,
                                "protein": protein,
                                "fat": fat,
                                "suagrs": suagrs,
                                'itemName': foodFields.itemName,
                                'mealType': this.mealType,
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
                        margin: EdgeInsets.only(right: 20),
                      ),
                    ]),
                  );
                },
                itemCount: _hitsList.length,
              );
            }
          } else if (snapShot.hasError) {
            developer.log('error' + snapShot.error.toString());
            renderedList = Container(child: Text('Search text invalid'));
          } else {
            // is loading
            developer.log('loading');
            renderedList = Container(child: Text('loading'));
          }
          return renderedList;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: _buildFutureListView());
  }
}
