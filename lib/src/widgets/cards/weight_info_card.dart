import 'package:flutter/material.dart';
import '../../assets/constants.dart';

class WeightInfoCard extends StatefulWidget {
  @override
  _WeightInfoCardState createState() => _WeightInfoCardState();
}

class _WeightInfoCardState extends State<WeightInfoCard> {
  Widget _buildWeightInfoContainers(String label, String value) {
    return Expanded(
        child: Container(
            margin: EdgeInsets.only(left: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                    child: Text(label,
                        style: labelStyle, textAlign: TextAlign.left)),
                Container(
                    child:
                        Text(value, style: valueStyle.copyWith(fontSize: 14))),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Wrap(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      'User',
                      style: valueStyle.copyWith(fontSize: 18),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  ),
                ),
                Container(
                  child: Icon(Icons.calendar_today, color: Colors.grey[300]),
                  margin: EdgeInsets.only(right: 20),
                )
              ],
            ),
            Row(
              children: [
                _buildWeightInfoContainers('Stage', 'Reduced'),
                _buildWeightInfoContainers('Now', '85.2 kg'),
                _buildWeightInfoContainers('Targeted', '80kg'),
                Expanded(
                    child: Container(
                  child: Icon(Icons.arrow_forward_ios, color: Colors.grey[300].withOpacity(0.4)),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 20),
                ))
              ],
            )
          ],
        ));
  }
}
