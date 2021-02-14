import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/requests/food_request.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/record_collection.dart';
import 'package:fyp_dieta/src/widgets/buttons/floating_buttons.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';
import 'package:fyp_dieta/src/widgets/inputs/search_form.dart';
import 'package:fyp_dieta/src/widgets/buttons/food_naviagtor_bottons.dart';
import 'package:fyp_dieta/src/widgets/layouts/select_list.dart';
import 'package:redux/redux.dart';

class FoodScreen extends StatefulWidget {
  static const String routeName = '/food';
  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class FoodScreenArguments {
  FoodScreenArguments({@required this.mealType});

  final int mealType;
}

class _FoodScreenState extends State<FoodScreen> {
  final List<String> mealLabelList = <String>[
    'Breakfast',
    'Lunch',
    'Dinner',
    'Extra'
  ];
  List<dynamic> mealList = <dynamic>[];

  Future<void> setRecordData(String uid, int mealType) async {
    try {
      final DocumentSnapshot recordSnapshot =
          await RecordCollection(uid: uid, date: currentDate)
              .getAllRecordsByDate();
      if (recordSnapshot.data() != null &&
          recordSnapshot.data().containsKey('food')) {
        final Map<String, dynamic> recordData = recordSnapshot.data();
        setState(() {
          final List<dynamic> temp = <dynamic>[];
          recordData['food'].forEach((dynamic item) {
            if (item['mealType'] == mealType) {
              temp.add(item);
            }
          });
          mealList = temp;
        });
      }
    } catch (err) {
      Toast.showFailedMsg(context: context, message: 'err');
    }
  }

  Widget _renderSelectList({AppState state, int mealType}) {
    final String searchText = state.foodState.search;
    if (searchText != null) {
      return Expanded(
          child: SelectList(
              foodResponse: fetchFood(searchText),
              uid: state.userState.user.uid,
              mealType: mealType));
    }
    return const Text('Please search food');
  }

  Widget _buildListView({String uid}) {
    if (mealList.isEmpty) {
      return ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
           ListTile(
            title: Text('Have no records yet ...',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          ),
        ],
      );
    }
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: mealList.length,
        itemBuilder: (BuildContext context, int index) {
          final String itemName = mealList[index]['itemName'] as String;
          return ListTile(
            leading: IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: () async {
                  try {
                    await RecordCollection(uid: uid, date: currentDate)
                        .removeFoodRecord(
                            mealList[index] as Map<String, dynamic>);
                    Toast.showSuccessMsg(message: 'success', context: context);
                    setState(() {
                      mealList.removeAt(index);
                    });
                  } catch (err) {
                    Toast.showFailedMsg(
                        message: err.toString(), context: context);
                  }
                }),
            title: Text(itemName,
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // ignore
    final FoodScreenArguments args =
        ModalRoute.of(context).settings.arguments as FoodScreenArguments;
    return StoreConnector<AppState, AppState>(
        converter: (Store<AppState> store) => store.state,
        onInit: (Store<AppState> store) async {
          setRecordData(store.state.userState.user.uid, args.mealType);
        },
        builder: (BuildContext context, AppState appState) {
          return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  leading: IconButton(
                      icon: const Icon(
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
              drawer: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Drawer(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                            height: 120,
                            width: MediaQuery.of(context).size.width,
                            child: DrawerHeader(
                              decoration: BoxDecoration(
                                color: Theme.of(context).buttonColor,
                              ),
                              child: Text(
                                '${mealLabelList[args.mealType]} List',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
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
              body: Column(children: <Widget>[
                SearchForm(),
                FoodNavigatorBottons(currentSection: args.mealType),
                const Divider(thickness: 2),
                _renderSelectList(state: appState, mealType: args.mealType),
              ]));
        });
  }
}
