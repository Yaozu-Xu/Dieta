import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/assets/constants.dart';
import 'package:fyp_dieta/src/screens/collection_screen.dart';

class WeightInfoCard extends StatefulWidget {
  const WeightInfoCard(
      {@required this.username,
      @required this.uid,
      @required this.weightStaging,
      @required this.weight});

  final String username;
  final String uid;
  final int weightStaging;
  final dynamic weight;

  @override
  _WeightInfoCardState createState() => _WeightInfoCardState();
}

class _WeightInfoCardState extends State<WeightInfoCard> {
  final List<String> weightStagingList = <String>['Reduce', 'Maintain', 'Gain'];

  String targetedText() {
    final int flag = widget.weightStaging;
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
            margin: const EdgeInsets.only(left: 20, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(label,
                        style: labelStyle, textAlign: TextAlign.left)),
                Text(value, style: valueStyle.copyWith(fontSize: 14)),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Wrap(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                    child: Text(
                      widget.username,
                      style: valueStyle.copyWith(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child:  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    color: Colors.grey[300],
                    tooltip: 'Redesign your plan',
                    onPressed: () {
                      Navigator.pushNamed(context, CollectionScreen.routeName,
                          arguments: CollectionScreenArguments(
                              implyLeading: true, uid: widget.uid));
                    },
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                _buildWeightInfoContainers(
                    'Stage', weightStagingList[widget.weightStaging]),
                _buildWeightInfoContainers('Now', '${widget.weight} kg'),
                _buildWeightInfoContainers('Targeted', targetedText()),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 20),
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.grey[300].withOpacity(0.4)),
                ))
              ],
            )
          ],
        ));
  }
}
