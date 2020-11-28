import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:fyp_dieta/src/model/Food.dart';

class SelectList extends StatefulWidget {
  final Future<FoodResponse> _foodResponseFuture;
  const SelectList(this._foodResponseFuture);

  @override
  _SelectListState createState() => _SelectListState();
}

class _SelectListState extends State<SelectList> {
  @override
  void initState() {
    super.initState();
  }

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
        future: widget._foodResponseFuture,
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
                        ),
                        margin: EdgeInsets.only(right: 20),
                      )
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
