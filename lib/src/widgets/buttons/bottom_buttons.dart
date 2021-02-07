import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/diet_screen.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/screens/user_screen.dart';

class BottomButtons extends StatefulWidget {
  final int _currentIndex;
  const BottomButtons(this._currentIndex);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  final _routesList = [HomeScreen.routeName, DietScreen.routeName, UserScreen.routeName];

  void _onItemTapped(int index) {
    setState(() {
      if (index != widget._currentIndex) {
        Navigator.pushNamed(context, _routesList[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.event_note), label: 'Record'),
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), label: 'Diet'),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), label: 'User'),
      ],
      backgroundColor: Theme.of(context).bottomAppBarColor,
      currentIndex: widget._currentIndex,
      selectedItemColor: Colors.grey[200].withOpacity(0.9),
      unselectedItemColor: Colors.grey[200].withOpacity(0.4),
      onTap: _onItemTapped,
    );
  }
}
