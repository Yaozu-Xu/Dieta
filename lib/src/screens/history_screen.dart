import 'package:flutter_icons/flutter_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fyp_dieta/src/screens/home_screen.dart';
import 'package:fyp_dieta/src/utils/firebase/firestore/record_collection.dart';
import 'package:fyp_dieta/src/utils/local_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fyp_dieta/src/assets/constants.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeName = '/history';
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class HistoryScreenArguments {
  HistoryScreenArguments({@required this.uid});
  final String uid;
}

class RecordMap {
  RecordMap({@required this.hasFoodRecord, @required this.hasStepsRecord});
  final bool hasFoodRecord;
  final bool hasStepsRecord;
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  CalendarController _calendarController;
  final DateFormat _format = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    setSelectedDay();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animationController.forward();
  }

  Future<void> setSelectedDay() async {
     _calendarController.setSelectedDay(_format.parse(await getCurrentDate()));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  Future<void> _onDaySelected(DateTime day) async {
      setCurrentDate(date: _format.format(day));
      Navigator.pushNamed(context, HomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final HistoryScreenArguments args =
        ModalRoute.of(context).settings.arguments as HistoryScreenArguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Record', style: appBarStyle),
        backgroundColor: Theme.of(context).secondaryHeaderColor,
      ),
      body: Column(
        children: <Widget>[
          _buildTableCalendarWithBuilders(uid: args.uid),
        ],
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders({@required String uid}) {
    return FutureBuilder<QuerySnapshot>(
      future: RecordCollection(uid: uid).getAllRecords(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> recordSnapshot) {
        final Map<DateTime, List<RecordMap>> events =
            <DateTime, List<RecordMap>>{};
        // load events if have records
        if (recordSnapshot.hasData) {
          final List<QueryDocumentSnapshot> recordList =
              recordSnapshot.data.documents as List<QueryDocumentSnapshot>;
          for (final DocumentSnapshot e in recordList) {
            events[_format.parse(e.id)] = <RecordMap>[
              RecordMap(
                  hasFoodRecord: e.data().containsKey('food'),
                  hasStepsRecord: e.data().containsKey('steps'))
            ];
          }
        }
        return TableCalendar(
          events: events,
          calendarController: _calendarController,
          availableCalendarFormats: const<CalendarFormat, String> {
            CalendarFormat.month: '',
            CalendarFormat.week: '',
          },
          calendarStyle: const CalendarStyle(
            outsideDaysVisible: false,
            weekendStyle: TextStyle(color: Colors.black),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.grey[600]),
          ),
          headerStyle: const HeaderStyle(
            centerHeaderTitle: true,
            formatButtonVisible: false,
          ),
          builders: CalendarBuilders(
            selectedDayBuilder: (BuildContext context, DateTime date, _) {
              return FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(_animationController),
                child: Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.only(top: 14, left: 14),
                  color: Colors.deepOrange[100],
                  width: 100,
                  height: 100,
                  child: Text(
                    '${date.day}',
                    style: const TextStyle().copyWith(fontSize: 16.0),
                  ),
                ),
              );
            },
            markersBuilder: (BuildContext context, DateTime date, List<dynamic >events, List<dynamic> holidays) {
              final List<Widget> children = <Widget>[];
              if (events.isNotEmpty) {
                final RecordMap m = events.first as RecordMap;
                if (m.hasFoodRecord) {
                  children.add(
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: _buildMealMarker()
                    ),
                  );
                }
                if (m.hasStepsRecord) {
                  children.add(
                    Positioned(
                      left: 1,
                      top: 1,
                      child: _buildSportsMarker()
                    ),
                  );
                }

              }
              return children;
            },
          ),
          onDaySelected: (DateTime date, List<dynamic> events, List<dynamic> holidays) {
            _onDaySelected(date);
            _animationController.forward(from: 0.0);
          },
        );
      },
    );
  }

  Widget _buildSportsMarker() {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 16.0,
        height: 16.0,
        child: Icon(
         Icons.run_circle_rounded,
          color: Colors.blue[400],
          size: 18
        ));
  }

  Widget _buildMealMarker() {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 16.0,
        height: 16.0,
        child: Icon(
         FlutterIcons.apple_alt_faw5s,
          color: Colors.red[400],
          size: 16
        ));
  }
}
