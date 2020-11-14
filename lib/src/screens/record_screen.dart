import 'package:flutter/material.dart';
import '../widgets/cards/calories_card.dart';
import '../widgets/buttons/bottom_buttons.dart';

class RecordScreen extends StatelessWidget {
  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record', style: TextStyle(letterSpacing: 1.2, color: Colors.grey[200].withOpacity(0.4))),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomButtons(0),
      backgroundColor: Theme.of(context).primaryColorDark,
      body: (
        CaloriesCard()
      ),
    );
  }
}
