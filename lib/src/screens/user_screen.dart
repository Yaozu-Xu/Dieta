import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/widgets/layouts/user_stream_builder.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/utils/firebase/sign_in.dart';
import 'package:redux/redux.dart';

import 'collection_screen.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  final List<String> _sportsLevelLabelLists = <String>[
    'Light',
    'Moderate',
    'Heavy'
  ];
  final List<String> _weightStagingList = <String>[
    'Reduce',
    'Maintain',
    'Gain'
  ];

  Widget _buildRightLebel(String labelName) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.only(right: 40),
            child: Text(labelName ?? '',
                textAlign: TextAlign.right, style: listLabelStyle)));
  }

  Widget _loadAvatar(String url) {
    if (url != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(url),
      );
    }
    return const CircleAvatar(
        backgroundImage: AssetImage('lib/src/assets/image/user.png'));
  }

  Widget _buildMenuList(BuildContext context, UserState userState) {
    final String sportsLabel =
        _sportsLevelLabelLists[userState.settings.sportsLevel];
    final String weightLabel =
     _weightStagingList[userState.settings.weightStaging];
    return ListView(
      children: <Widget>[
        _buildListItem(
            context,
            Row(children: <Widget>[
              _loadAvatar(userState.user.photoURL),
              _buildRightLebel(userState.user.displayName)
            ])),
        _buildRowWithIcon(
            context: context,
            icon: Icons.accessibility,
            label: '${userState.settings.height} cm'),
        _buildRowWithIcon(
            context: context,
            icon: FlutterIcons.weight_kilogram_mco,
            label: '${userState.settings.weight} kg'),
        _buildRowWithIcon(
            context: context,
            icon: FlutterIcons.running_faw5s,
            label: sportsLabel),
        _buildRowWithIcon(
            context: context,
            icon: FlutterIcons.target_fea,
            label: weightLabel),
        _buildRowWitBtn(
            context: context,
            icon: Icons.settings_applications,
            child: Container(
              margin: const EdgeInsets.only(right: 40),
              child: OutlineButton(
                  borderSide:
                      BorderSide(color: Colors.grey[300].withOpacity(0.4)),
                  onPressed: () async {
                    Navigator.pushNamed(context, CollectionScreen.routeName,
                        arguments: CollectionScreenArguments(
                            implyLeading: true, uid: userState.user.uid));
                  },
                  child: Text(
                    'Update',
                    style: listLabelStyle,
                  )),
            )),
        _buildRowWitBtn(
            context: context,
            icon: Icons.logout,
            child: Container(
              margin: const EdgeInsets.only(right: 40),
              child: OutlineButton(
                  borderSide:
                      BorderSide(color: Colors.grey[300].withOpacity(0.4)),
                  onPressed: () async {
                    await signOutGoogle();
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'Log Out',
                    style: listLabelStyle,
                  )),
            )),
      ],
    );
  }

  Widget _buildListItem(BuildContext context, Widget child) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
      color: Theme.of(context).cardColor,
      child: child,
    );
  }

  Widget _buildRowWitBtn({BuildContext context, IconData icon, Widget child}) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
        color: Theme.of(context).cardColor,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 5),
              child: Icon(
                icon,
                color: Colors.grey[300],
                size: 26,
              ),
            ),
            const Spacer(),
            child,
          ],
        ));
  }

  Widget _buildRowWithIcon(
      {BuildContext context, IconData icon, String label}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 0, 10),
      color: Theme.of(context).cardColor,
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 5),
            child: Icon(
              icon,
              color: Colors.grey[300],
              size: 26,
            ),
          ),
          _buildRightLebel(label)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('User',
              style: TextStyle(
                  letterSpacing: 1.2,
                  color: Colors.grey[200].withOpacity(0.4))),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: const BottomButtons(2),
        backgroundColor: Theme.of(context).primaryColorDark,
        body: UserStreamBuilder(
            buildedWidget: StoreConnector<AppState, UserState>(
          converter: (Store<AppState> store) => store.state.userState,
          builder: (BuildContext context, UserState userState) {
            return _buildMenuList(context, userState);
          },
        )));
  }
}
