import 'package:flutter/material.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/validator.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/user_collection.dart';
import 'package:fyp_dieta/src/widgets/common/toast.dart';
import 'package:fyp_dieta/src/widgets/inputs/bordered_input.dart';
import 'package:fyp_dieta/src/utils/calories_calculator.dart';

class CollectionScreen extends StatefulWidget {
  static const String routeName = '/collection';
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

enum GenderCharacter { male, female }

class CollectionScreenArguments {
  CollectionScreenArguments({@required this.implyLeading, @required this.uid});

  final bool implyLeading;
  final String uid;
}

class _CollectionScreenState extends State<CollectionScreen> {
  GenderCharacter _sex = GenderCharacter.male;
  int _sportsLevel;
  int _weightStaging;
  int _age;
  double _height;
  double _weight;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final List<String> _sportsLevelLabelLists = <String>[
    'Light',
    'Moderate',
    'Heavy'
  ];
  final List<String> _weightStagingList = <String>[
    'Reduce',
    'Maintain',
    'Gain'
  ];

  Container _buildDropDownList(
      {int index,
      List<String> list,
      String hint,
      Function(dynamic) onChanged}) {
    return Container(
        margin: const EdgeInsets.only(top: 10, right: 30, left: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.grey[500],
            )),
        child: DropdownButton<dynamic>(
          value: index,
          hint: Container(
              margin: const EdgeInsets.only(left: 10), child: Text(hint)),
          elevation: 16,
          underline: const SizedBox(),
          onChanged: onChanged,
          items: list.map<DropdownMenuItem<dynamic>>((String value) {
            return DropdownMenuItem<dynamic>(
              value: list.indexOf(value),
              child: Container(
                width: 175,
                padding: const EdgeInsets.only(left: 10),
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
        ModalRoute.of(context).settings.arguments as CollectionScreenArguments;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Personal Data'),
          automaticallyImplyLeading: args.implyLeading ?? false,
        ),
        body: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 50),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Row(
                    children: <Widget>[
                      const Spacer(),
                      Radio<GenderCharacter>(
                        value: GenderCharacter.male,
                        groupValue: _sex,
                        onChanged: (GenderCharacter value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                      const Text('Male', style: TextStyle(fontSize: 16)),
                      Radio<GenderCharacter>(
                        value: GenderCharacter.female,
                        groupValue: _sex,
                        onChanged: (GenderCharacter value) {
                          setState(() {
                            _sex = value;
                          });
                        },
                      ),
                      const Text('Female', style: TextStyle(fontSize: 16)),
                      const Spacer(),
                    ],
                  ),
                ),
                BorderDecoration(
                  placeHolder: 'Age Year',
                  validator: Validator.ageValidator,
                  onChanged: (String age) {
                    setState(() {
                      _age = int.parse(age);
                    });
                  },
                ),
                BorderDecoration(
                  placeHolder: 'Height CM',
                  validator: Validator.heightValidator,
                  onChanged: (String height) {
                    setState(() {
                      _height = double.parse(height);
                    });
                  },
                ),
                BorderDecoration(
                  placeHolder: 'Weight KG',
                  validator: Validator.weightValidator,
                  onChanged: (String weight) {
                    setState(() {
                      _weight = double.parse(weight);
                    });
                  },
                ),
                _buildDropDownList(
                  index: _sportsLevel,
                  list: _sportsLevelLabelLists,
                  hint: 'Activity Level',
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _sportsLevel = newValue as int;
                    });
                  },
                ),
                _buildDropDownList(
                  index: _weightStaging,
                  list: _weightStagingList,
                  hint: 'Weight Staging',
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _weightStaging = newValue as int;
                    });
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: ButtonTheme(
                    minWidth: 200,
                    buttonColor: Colors.orange[400],
                    child: RaisedButton(
                      onPressed: () async {
                        if (!_formkey.currentState.validate()) return;
                        try {
                          final int totalCalories = CaloriesCalculator(
                                  activityLevel: _sportsLevel,
                                  age: _age,
                                  sex: _sex.index,
                                  height: _height,
                                  weight: _weight,
                                  weightStaging: _weightStaging)
                              .calculateTotalEnergy();
                          await UserCollection()
                              .addUserSettings(args.uid, <String, dynamic>{
                            'age': _age,
                            'sex': _sex.index,
                            'height': _height,
                            'weight': _weight,
                            'weightStaging': _weightStaging,
                            'sportsLevel': _sportsLevel,
                            'totalCalories': totalCalories,
                          });
                          Navigator.pushNamed(context, HomeScreen.routeName);
                        } catch (err) {
                          Toast.showFailedMsg(context: context, message: 'err');
                        }
                      },
                      child: const Text(
                        'Calculate',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            )));
  }
}
