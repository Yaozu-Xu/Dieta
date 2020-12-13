import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/widgets/buttons/bottom_buttons.dart';

class UserScreen extends StatelessWidget {
  static const routeName = '/user';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomButtons(2),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
      ),
    );
  }
}
