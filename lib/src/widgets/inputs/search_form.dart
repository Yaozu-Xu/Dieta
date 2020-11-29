import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/actions/food_action.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/food_state.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final _controller = TextEditingController();
  Timer _debounce;

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(
        const Duration(milliseconds: 500),
        () => {
              StoreProvider.of<AppState>(context)
                  .dispatch(SetFoodAction(FoodState(
                search: _controller.text,
                loaded: true,
              )))
            });
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[300]),
        child: Row(children: [
          Container(
            child: Icon(Icons.search),
            margin: EdgeInsets.only(left: 10, right: 10),
          ),
          Expanded(
              child: StoreConnector<AppState, FoodState>(
                  converter: (store) => store.state.foodState,
                  builder: (context, foodState) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter name of food',
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _controller,
                    );
                  }))
        ]));
  }
}
