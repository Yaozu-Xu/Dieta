import 'package:flutter/material.dart';

class BottomButtons extends StatefulWidget {
  final int _currentIndex;
  const BottomButtons(this._currentIndex);

  @override
  _BottomButtonsState createState() => _BottomButtonsState();
}

class _BottomButtonsState extends State<BottomButtons> {
  final _routesList = ['/', '/diet', '/user'];

  void _onItemTapped(int index) {
    setState(() {
      Navigator.pushNamed(context, _routesList[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.event_note), title: Text('Record')),
        BottomNavigationBarItem(
            icon: Icon(Icons.restaurant), title: Text('Diet')),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box), title: Text('User')),
      ],
      backgroundColor: Theme.of(context).bottomAppBarColor,
      currentIndex: widget._currentIndex,
      selectedItemColor: Colors.grey[200].withOpacity(0.9),
      unselectedItemColor: Colors.grey[200].withOpacity(0.4),
      onTap: _onItemTapped,
    );
  }
}
