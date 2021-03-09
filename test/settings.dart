import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/reducers/app_reducer.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:redux/redux.dart';

final Store<AppState> store =
    Store<AppState>(appReducer, initialState: AppState.intital());

Widget createMockApp(Widget testedWidget) => MediaQuery(
    data: const MediaQueryData(),
    child: StoreProvider<AppState>(
        store: store, child: MaterialApp(home: testedWidget)));