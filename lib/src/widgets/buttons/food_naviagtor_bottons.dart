import 'package:flutter/material.dart';

class FoodNavigatorBottons extends StatelessWidget {
  Widget _buildText(String label) {
    return (Expanded(
        child: Text(label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[500]))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 30),
      child: Row(
        children: [
         _buildText('Restaurant'),
         _buildText('Gorcery'),
         _buildText('Common'),
        ],
      ),
    );
  }
}
