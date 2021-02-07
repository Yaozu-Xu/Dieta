import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/requests/food_request.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/RecordCollection.dart';
import 'package:fyp_dieta/src/widgets/buttons/floating_buttons.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';
import 'package:fyp_dieta/src/widgets/inputs/search_form.dart';
import 'package:fyp_dieta/src/widgets/buttons/food_naviagtor_bottons.dart';
import 'package:fyp_dieta/src/widgets/layouts/select_list.dart';

class FoodScreen extends StatefulWidget {
  static const routeName = '/food';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class FoodScreenArguments {
  final int mealType;

  FoodScreenArguments({@required this.mealType});
}

class _FoodScreenState extends State<FoodScreen> {
  final List mealLabelList = ['Breakfast', 'Lunch', 'Dinner', 'Extra'];
  List mealList = [];

  void setRecordData(String uid, int mealType) async {
    try {
      final DocumentSnapshot recordSnapshot =
          await RecordCollection(uid: uid, date: currentDate)
              .getAllRecordsByDate();
      if (recordSnapshot.data() != null &&
          recordSnapshot.data().containsKey('food')) {
        Map recordData = recordSnapshot.data();
        setState(() {
          List temp = [];
          recordData['food'].forEach((item) => {
                if (item['mealType'] == mealType) {temp.add(item)}
              });
          this.mealList = temp;
        });
      }
    } catch (err) {
      print(err);
    }
  }

  Widget _renderSelectList({AppState state, int mealType}) {
    String searchText = state.foodState.search;
    if (searchText != null) {
      return Expanded(
          child: SelectList(
              foodResponse: fetchFood(searchText),
              uid: state.userState.user.uid,
              mealType: mealType));
    }
    return Container(child: Text('Please search food'));
  }

  Widget _buildListView({String uid}) {
    if (this.mealList.length == 0) {
      return ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Text('Have no records yet ...',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ),
        ],
      );
    }
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: this.mealList.length,
        itemBuilder: (context, index) {
          final String itemName = this.mealList[index]['itemName'];
          return ListTile(
            leading: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () async {
                  try {
                    await RecordCollection(uid: uid, date: currentDate)
                        .removeFoodRecord(this.mealList[index]);
                    Toast.showSuccessMsg(message: 'success', context: context);
                    setState(() {
                      this.mealList.removeAt(index);
                    });
                  } catch (err) {
                    Toast.showFailedMsg(
                        message: err.toString(), context: context);
                  }
                }),
            title: Text(itemName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final FoodScreenArguments args = ModalRoute.of(context).settings.arguments;
    return StoreConnector<AppState, AppState>(
        converter: (store) => store.state,
        onInit: (store) async {
          setRecordData(store.state.userState.user.uid, args.mealType);
        },
        builder: (context, appState) {
          return Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.keyboard_backspace,
                        size: 28,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      }),
                  title: Text(mealLabelList[args.mealType],
                      style: TextStyle(
                          letterSpacing: 1.2, color: Colors.grey[200])),
                  backgroundColor: Theme.of(context).buttonColor,
                  iconTheme: IconThemeData(color: Colors.grey[200])),
              floatingActionButton: MealIconFloatingButton(
                  mealType: args.mealType,
                  callback: setRecordData,
                  uid: appState.userState.user.uid),
              drawer: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Drawer(
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            child: DrawerHeader(
                              decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                              ),
                              child: Text(
                                mealLabelList[args.mealType] + ' List',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )),
                        Expanded(
                            child: _buildListView(
                                uid: appState.userState.user.uid)),
                      ],
                    ),
                  )),
              body: Column(children: [
                SearchForm(),
                FoodNavigatorBottons(currentSection: args.mealType),
                Divider(thickness: 2),
                _renderSelectList(state: appState, mealType: args.mealType),
              ]));
        });
  }
}
