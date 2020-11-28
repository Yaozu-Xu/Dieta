import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/food_state.dart';
import 'package:fyp_dieta/src/requests/food_request.dart';
import 'package:fyp_dieta/src/widgets/inputs/search_form.dart';
import 'package:fyp_dieta/src/widgets/buttons/food_naviagtor_bottons.dart';
import 'package:fyp_dieta/src/widgets/layouts/select_list.dart';

class FoodScreen extends StatefulWidget {
  static const routeName = '/food';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget _renderSelectList(state) {
    if(state.loaded) {
      return Expanded(child: SelectList(fetchFood(state.search)));
    }
    return Container(child: Text('Please search food'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Food List',
                style: TextStyle(letterSpacing: 1.2, color: Colors.grey[200])),
            backgroundColor: Theme.of(context).buttonColor,
            iconTheme: IconThemeData(color: Colors.grey[200])),
        body: StoreConnector<AppState, FoodState>(
            converter: (store) => store.state.foodState,
            builder: (context, foodState) {
              return Column(children: [
                SearchForm(),
                FoodNavigatorBottons(),
                Divider(thickness: 2),
                _renderSelectList(foodState),
              ]);
            }));
  }
}
