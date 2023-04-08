// import 'dart:ui';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/data.dart';
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
    // final firstDayOfYear = DateTime(2023, 1, 1);
    // final firstDayOfWeek =
    //     firstDayOfYear.subtract(Duration(days: firstDayOfYear.weekday - 1));
    // final lastDayOfWeek = firstDayOfWeek.add(Duration(days: 6));
    // final weekdays = DateFormat('EEE').format(firstDayOfWeek).toUpperCase() +
    //     ' - ' +
    //     DateFormat('EEE').format(lastDayOfWeek).toUpperCase();
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

        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           IconButton(
        //             onPressed: _previousWeek,
        //             icon: Icon(Icons.arrow_left),
        //           ),
        //           Text(
        //             DateFormat('MMMM d, y').format(__currentDate),
        //             style: TextStyle(fontSize: 18),
        //           ),
        //           IconButton(
        //             onPressed: _nextWeek,
        //             icon: Icon(Icons.arrow_right),
        //           ),
        //         ],
        //       ),
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: _buildWeekDays(),
        //       ),
        //     ],
        //   ),
        // ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        //       child: Text(
        //         'Week $_weekNumber, ${DateFormat('MMMM yyyy').format(_startDate)}',
        //         style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 20.0,
        //         ),
        //       ),
        //     ),
        //     Expanded(
        //       child: GridView.count(
        //         crossAxisCount: 7,
        //         children: List.generate(
        //           7,
        //           (index) => Padding(
        //             padding: EdgeInsets.all(8.0),
        //             child: Text(
        //               DateFormat('EEE')
        //                   .format(_startDate.add(Duration(days: index))),
        //               style: TextStyle(fontSize: 16.0),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: EdgeInsets.all(16.0),
        //       child: ElevatedButton(
        //         onPressed: _nextWeek,
        //         child: Text('Next Week'),
        //       ),
        //     ),
        //   ],
        // )
        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Calendar'),
        //   ),
        //   body: Column(
        //     children: [
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         alignment: Alignment.center,
        //         child: Text(
        //           'Week 1 of 2023',
        //           style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //         ),
        //       ),
        //       Container(
        //         padding: EdgeInsets.all(16),
        //         alignment: Alignment.center,
        //         child: Text(
        //           weekdays,
        //           style: TextStyle(fontSize: 18),
        //         ),
        //       ),
        //       Expanded(
        //         child: GridView.count(
        //           crossAxisCount: 7,
        //           children: List.generate(7, (index) {
        //             final date = firstDayOfWeek.add(Duration(days: index));
        //             return Container(
        //               padding: EdgeInsets.all(16),
        //               alignment: Alignment.center,
        //               child: Text(
        //                 DateFormat('d').format(date),
        //                 style: TextStyle(fontSize: 18),
        //               ),
        //             );
        //           }),
        //         ),
        //       ),
        //     ],
        //   ),
        // );
        // return Scaffold(
        //   appBar: AppBar(
        //     title: Text('Single Day'),
        //     backgroundColor: Theme.of(context).primaryColor,
        //     leading: IconButton(
        //       icon: Icon(Icons.dehaze),
        //       onPressed: () {
        //         if (_scaffoldkey.currentState.isDrawerOpen == false) {
        //           _scaffoldkey.currentState.openDrawer();
        //         } else {
        //           _scaffoldkey.currentState.openEndDrawer();
        //         }
        //       },
        //     ),
        //   ),
        //   body: Scaffold(
        //     key: _scaffoldkey,
        //     drawer: NavBar(),
        //     // body: TableCalendar(
        //     //   firstDay: DateTime.utc(2010, 10, 16),
        //     //   lastDay: DateTime.utc(2030, 3, 14),
        //     //   focusedDay: DateTime.now(),
        //     //   calendarFormat: CalendarFormat.week,
        //     //   calendarStyle: CalendarStyle(
        //     //     weekendDecoration: BoxDecoration(
        //     //       color: Colors.cyan[100],
        //     //     ),

        //     //     // rowDecoration: BoxDecoration,
        //     //   ),
        //     //   onDaySelected: showMyDialog(context),
        //     // ),
        //     body: Column(
        //       children: [
        //         Padding(
        //             padding: const EdgeInsets.all(25),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 IconButton(
        //                     onPressed: () {},
        //                     icon: Icon(
        //                       Icons.arrow_circle_left,
        //                       color: Theme.of(context).accentColor,
        //                     )),
        //                 TextButton(
        //                   onPressed: _presentDatePicker,
        //                   child: Text("$today - $day7",
        //                       style: TextStyle(
        //                           fontSize: 16,
        //                           fontWeight: FontWeight.bold,
        //                           color: Colors.grey)),
        //                 ),
        //                 IconButton(
        //                     onPressed: () {},
        //                     icon: Icon(
        //                       Icons.arrow_circle_right,
        //                       color: Theme.of(context).accentColor,
        //                     )),
        //               ],
        //             )),
        //         GridView(
        //           shrinkWrap: true,
        //           padding: const EdgeInsets.all(25),
        //           children: DAYS_OF_WEEK
        //               .map(
        //                 (days) => DayItem(
        //                   days.title,
        //                   days.color,
        //                 ),
        //               )
        //               .toList(),
        //           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //             maxCrossAxisExtent: 200,
        //             childAspectRatio: 3 / 2,
        //             crossAxisSpacing: 20,
        //             mainAxisSpacing: 20,
        //           ),
        //         ),
        //       ],
        //     ),
      ),
    );
  }
}
