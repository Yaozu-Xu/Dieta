import 'package:flutter/material.dart';
import '../widgets/buttons/bottom_buttons.dart';

class DietScreen extends StatelessWidget {
  static const routeName = '/diet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diet'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomButtons(1),
    );
  }
}
