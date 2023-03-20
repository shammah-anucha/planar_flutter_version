import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/data.dart';
import 'package:planar_fluteer_version/models/days.dart';
import 'package:planar_fluteer_version/widgets/day_item.dart';
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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedDate) {
      if (pickedDate.day == DAYS_OF_WEEK.first.title) {
        DAYS_OF_WEEK.first.color = Colors.red;
      }
      // } else {
      //   return;
      // }
    });

    ;
  }

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
                    padding: const EdgeInsets.all(25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_left,
                              color: Theme.of(context).accentColor,
                            )),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: Text('13.09.2023 - 15.09.2023',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_circle_right,
                              color: Theme.of(context).accentColor,
                            )),
                      ],
                    )),
                GridView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(25),
                  children: DAYS_OF_WEEK
                      .map(
                        (days) => DayItem(
                          days.title,
                          days.color,
                        ),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                ),
              ],
            )));
  }
}
