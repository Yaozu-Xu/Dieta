import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fyp_dieta/src/redux/states/app_state.dart';
import 'package:fyp_dieta/src/redux/states/user_state.dart';
import 'package:fyp_dieta/src/widgets/layouts/user_stream_builder.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/utils/firebase/sign_in.dart';
import 'package:redux/redux.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';

  Widget _buildRightLebel(String labelName) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.only(right: 40),
            child: Text(labelName ?? '',
                textAlign: TextAlign.right, style: listLabelStyle)));
  }

  Widget _loadAvatar(String url) {
    if(url != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(url),
      );
    }
    return const CircleAvatar(backgroundImage: AssetImage('lib/src/assets/image/user.png'));
  }

  Widget _buildMenuList(BuildContext context, UserState userState) {
    return ListView(
      children: <Widget>[
        _buildListItem(
            context,
            Row(children: <Widget>[
              _loadAvatar(userState.user.photoURL),
              _buildRightLebel(userState.user.displayName)
            ])),
        _buildListItem(
            context,
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.grey[300],
                    size: 26,
                  ),
                ),
                _buildRightLebel('10 days')
              ],
            )),
        _buildListItem(
            context,
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.settings_applications,
                    color: Colors.grey[300],
                    size: 26,
                  ),
                ),
                const Spacer(),
                Container(
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
                )
              ],
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
