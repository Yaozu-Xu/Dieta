import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/actions/food_action.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/food_state.dart';
import 'package:fyp_dieta/src/widgets/layouts/frosted_glass.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _controller = TextEditingController();
  Timer _debounce;

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(
        const Duration(milliseconds: 800),
        () => StoreProvider.of<AppState>(context)
                .dispatch(SetFoodAction(FoodState(
              search: _controller.text,
            ))));
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
    return FrostedGlass(
        height: 60,
        opacity: 0.4,
        margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
        borderRadius: BorderRadius.circular(20),
        innerChild: Form(
            child: Row(children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: const Icon(Icons.search),
          ),
          Expanded(
              child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter name of food',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintStyle: TextStyle(color: Colors.black)
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: _controller,
          ))
        ])));
  }
}
