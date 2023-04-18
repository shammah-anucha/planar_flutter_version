import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/models/days.dart';
import 'package:planar_fluteer_version/widgets/day_item.dart';
import 'package:table_calendar/table_calendar.dart';
import '../widgets/new_vacation.dart';
import '../widgets/vacations_list.dart';
import '../models/vacation.dart';
import '../widgets/navbar.dart';

class SingleDayScreen extends StatefulWidget {
  static const routeName = '/singleday';

  @override
  State<SingleDayScreen> createState() => _SingleDayScreenState();
}

class _SingleDayScreenState extends State<SingleDayScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  DateTime _currentDate =
      DateTime(2023, 1, 1); // Start date is 1st January, 2023

  void _previousWeek() {
    setState(() {
      _currentDate = _currentDate.subtract(Duration(days: 7));
    });
  }

  void _nextWeek() {
    setState(() {
      _currentDate = _currentDate.add(Duration(days: 7));
    });
  }

  // DateTime _startDate = DateTime(2023, 1, 1); // Start date is January 1, 2023
  // DateTime __currentDate =
  //     DateTime(2023, 1, 1); // Current date is January 1, 2023

  // void _previousWeek() {
  //   setState(() {
  //     __currentDate = __currentDate.subtract(Duration(days: 7));
  //   });
  // }

  // void _nextWeek() {
  //   setState(() {
  //     __currentDate = __currentDate.add(Duration(days: 7));
  //   });
  // }

  // List<Widget> _buildWeekDays() {
  //   List<Widget> days = [];

  //   // Add a Text widget for each day of the week
  //   for (int i = 0; i < 7; i++) {
  //     DateTime date = __currentDate.add(Duration(days: i));
  //     String dayOfWeek = DateFormat('E').format(date);
  //     String dayOfMonth = DateFormat('d').format(date);
  //     days.add(
  //       Column(
  //         children: [
  //           Text(dayOfWeek),
  //           Text(dayOfMonth),
  //         ],
  //       ),
  //     );
  //   }

  //   return days;
  // }
  // DateTime _startDate = DateTime(2023, 1, 1);
  // int _weekNumber = 1;

  // void _nextWeek() {
  //   setState(() {
  //     _startDate = _startDate.add(Duration(days: 7));
  //     _weekNumber++;
  //   });
  // }

  String today = DateFormat.yMd().format(DateTime.now());
  String day7 =
      DateFormat.yMd().format(DateTime.now().add(const Duration(days: 7)));

  // void _presentDatePicker() {
  //   showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2025),
  //   ).then((pickedDate) {
  //     if (pickedDate.day == DAYS_OF_WEEK.first.title) {
  //       DAYS_OF_WEEK.first.color = Colors.red;
  //     }
  //     // } else {
  //     //   return;
  //     // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Single Day'),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {
            if (_scaffoldkey.currentState.isDrawerOpen == false) {
              _scaffoldkey.currentState.openDrawer();
            } else {
              _scaffoldkey.currentState.openEndDrawer();
            }
          },
        ),
      ),
      body: Scaffold(
        key: _scaffoldkey,
        drawer: NavBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                DateFormat.MMMM().format(_currentDate),
                style: (TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: _previousWeek,
                  icon: Icon(Icons.arrow_left),
                ),
                Text(
                  DateFormat.yMMMd().format(_currentDate) +
                      ' - ' +
                      DateFormat.yMMMd()
                          .format(_currentDate.add(Duration(days: 7))),
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: _nextWeek,
                  icon: Icon(Icons.arrow_right),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                padding: const EdgeInsets.all(20),
                children: List.generate(7, (index) {
                  DateTime date = _currentDate.add(Duration(days: index));
                  return DayItem(DateFormat('EEEE').format(date),
                      DateFormat.yMMMd().format(date));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
