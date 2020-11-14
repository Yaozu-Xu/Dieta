import 'package:flutter/material.dart';

class CaloriesCard extends StatefulWidget {
  @override
  _CaloriesCardState createState() => _CaloriesCardState();
}

class _CaloriesCardState extends State<CaloriesCard> {
  final String leftColumnLabel = 'Intake';
  final String rightColumnLabel = 'Consume';

  Widget _buildExpandedColumn(String label, String count) {
    return Expanded(
        child: Container(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(count,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[300])),
            Text(label,
                style: TextStyle(
                    color: Colors.grey[300].withOpacity(0.4),
                    fontWeight: FontWeight.bold)),
          ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        children: [
          _buildExpandedColumn(leftColumnLabel, '100'),
          Container(
              child: Column(children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    constraints: BoxConstraints.tightForFinite(
                      height: 80,
                      width: 80,
                    ),
                    child: CircularProgressIndicator(
                      value: .8,
                      strokeWidth: 5,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation(Colors.cyanAccent[100]),
                    )),
                Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      '2000卡',
                      style: TextStyle(
                          color: Colors.grey[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
              ]),
              height: 200),
          _buildExpandedColumn(rightColumnLabel, '200')
        ],
      ),
    );
  }
}
