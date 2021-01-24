import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/UserCollection.dart';
import 'package:fyp_dieta/src/widgets/inputs/bordered_input.dart';
import 'package:fyp_dieta/src/utils/calories_calculator.dart';

class CollectionScreen extends StatefulWidget {
  static const routeName = '/collection';
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

enum GenderCharacter { male, female }

class CollectionScreenArguments {
  final bool implyLeading;
  final String uid;

  CollectionScreenArguments({@required this.implyLeading, @required this.uid});
}

class _CollectionScreenState extends State<CollectionScreen> {
  GenderCharacter _sex = GenderCharacter.male;
  int _sportsLevel;
  int _weightStaging;
  int _age;
  double _height;
  double _weight;
  List<String> _sportsLevelLabelLists = ['Light', 'Moderate', 'Heavy'];
  List<String> _weightStagingList = ['Reduce', 'Maintain', 'Gain'];

  _buildDropDownList(
      {int index, List<String> list, String hint, Function onChanged}) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey[500],
              width: 1.0,
            )),
        child: DropdownButton(
          value: index,
          hint: Container(margin: EdgeInsets.only(left: 10), child: Text(hint)),
          iconSize: 24,
          elevation: 16,
          underline: SizedBox(),
          onChanged: onChanged,
          items: list.map<DropdownMenuItem>((String value) {
            return DropdownMenuItem(
              value: list.indexOf(value),
              child: Container(
                width: 175,
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  value,
                ),
              ),
            );
          }).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final CollectionScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Data'),
        automaticallyImplyLeading: args.implyLeading ?? false,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 50),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 200),
            child: Row(
              children: [
                Spacer(),
                Radio(
                  value: GenderCharacter.male,
                  groupValue: _sex,
                  onChanged: (value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
                Text('Male', style: TextStyle(fontSize: 16)),
                Radio(
                  value: GenderCharacter.female,
                  groupValue: _sex,
                  onChanged: (value) {
                    setState(() {
                      _sex = value;
                    });
                  },
                ),
                Text('Female', style: TextStyle(fontSize: 16)),
                Spacer(),
              ],
            ),
          ),
          BorderDecoration(
            placeHolder: 'Age Year',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (age) {
              setState(() {
                this._age = int.parse(age);
              });
            },
          ),
          BorderDecoration(
            placeHolder: 'Height CM',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (height) {
              setState(() {
                this._height = double.parse(height);
              });
            },
          ),
          BorderDecoration(
            placeHolder: 'Weight KG',
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onChanged: (weight) {
              setState(() {
                this._weight = double.parse(weight);
              });
            },
          ),
          _buildDropDownList(
            index: this._sportsLevel,
            list: this._sportsLevelLabelLists,
            hint: 'Activity Level',
            onChanged: (newValue) {
              setState(() {
                this._sportsLevel = newValue;
              });
            },
          ),
          _buildDropDownList(
            index: this._weightStaging,
            list: this._weightStagingList,
            hint: 'Weight Staging',
            onChanged: (newValue) {
              setState(() {
                this._weightStaging = newValue;
              });
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ButtonTheme(
              minWidth: 200,
              buttonColor: Colors.orange[400],
              child: RaisedButton(
                onPressed: () async {
                  try {
                    int totalCalories = CaloriesCalculator(
                          activityLevel: this._sportsLevel,
                          age: this._age,
                          sex: this._sex.index,
                          height: this._height,
                          weight: this._weight,
                          weightStaging: this._weightStaging)
                      .calculateTotalEnergy();
                    await UserCollection().addUserSettings(args.uid, <String, dynamic>{
                      "age": this._age,
                      "sex": this._sex.index,
                      "height": this._height,
                      "weight": this._weight,
                      "weightStaging": this._weightStaging,
                      "sportsLevel": this._sportsLevel,
                      "totalCalories": totalCalories,
                    });
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  } catch (err) {
                    print(err.toString());
                  }
                },
                child: Text(
                  'Calculate',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
