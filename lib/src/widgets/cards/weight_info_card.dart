import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';

class WeightInfoCard extends StatefulWidget {
  final String username;
  final String uid;
  final int weightStaging;
  final dynamic weight;

  const WeightInfoCard(
      {@required this.username,
      @required this.uid,
      @required this.weightStaging,
      @required this.weight});

  @override
  _WeightInfoCardState createState() => _WeightInfoCardState();
}

class _WeightInfoCardState extends State<WeightInfoCard> {
  final List<String> weightStagingList = ['Reduce', 'Maintain', 'Gain'];

  String targetedText() {
    int flag = widget.weightStaging;
    if (flag == 0) {
      return '${widget.weight - 5} kg';
    } else if (flag == 1) {
      return '${widget.weight} kg';
    }
    return '${widget.weight + 5} kg';
  }

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
                      widget.username,
                      style: valueStyle.copyWith(fontSize: 18),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
                  ),
                ),
                Container(
                  child: IconButton(
                    icon: Icon(Icons.calendar_today),
                    color: Colors.grey[300],
                    tooltip: 'Redesign your plan',
                    onPressed: () {
                      Navigator.pushNamed(context, CollectionScreen.routeName,
                          arguments: CollectionScreenArguments(
                              implyLeading: true, uid: widget.uid));
                    },
                  ),
                  margin: EdgeInsets.only(right: 20),
                )
              ],
            ),
            Row(
              children: [
                _buildWeightInfoContainers(
                    'Stage', weightStagingList[widget.weightStaging]),
                _buildWeightInfoContainers('Now', '${widget.weight} kg'),
                _buildWeightInfoContainers('Targeted', targetedText()),
                Expanded(
                    child: Container(
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.grey[300].withOpacity(0.4)),
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 20),
                ))
              ],
            )
          ],
        ));
  }
}
