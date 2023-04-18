import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/screen/singleday_screen.dart';
import '../screen/calendar_screen.dart';
import '../screen/home_screen.dart';
import '../screen/inbox_screen.dart';
import '../screen/logout_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/roster_screen.dart';
import '../screen/setting_screen.dart';
import '../screen/vacation_screen.dart';
import '../screen/upcoming_events_screen.dart';
import '../screen/admin/admin_screen.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  var _expanded = false;

  // GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  Widget buildListTile(String title, Function tapHandler) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      // hoverColor: Colors.grey[300],
      title: Text(title),
      onTap: tapHandler,
      trailing: title == 'Unavailability'
          ? IconButton(
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more))
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildListTile('Home', () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          buildListTile('Roster', () {
            Navigator.of(context).pushReplacementNamed(RosterScreen.routeName);
          }),
          buildListTile('Unavailability', () {}),
          if (_expanded)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: MediaQuery.of(context).size.height * 0.1,
              child: ListView(children: [
                buildListTile('Vacations', () {
                  Navigator.of(context)
                      .pushReplacementNamed(VacationsScreen.routeName);
                }),
                buildListTile('Single Day', () {
                  Navigator.of(context)
                      .pushReplacementNamed(SingleDayScreen.routeName);
                }),
              ]),
            ),
          buildListTile('Upcoming Events', () {
            Navigator.of(context)
                .pushReplacementNamed(UpComingEventScreen.routeName);
          }),
          buildListTile('Calendar', () {
            Navigator.of(context)
                .pushReplacementNamed(CalendarScreen.routeName);
          }),
          buildListTile('Inbox', () {
            Navigator.of(context).pushReplacementNamed(InboxScreen.routeName);
          }),
          buildListTile('Profile', () {
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
          }),
          buildListTile('Admin', () {
            Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
          }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
          ),
          buildListTile('Logout', () {
            Navigator.of(context).pushReplacementNamed(LogoutScreen.routeName);
          }),
          buildListTile('Settings', () {
            Navigator.of(context)
                .pushReplacementNamed(SettingsScreen.routeName);
          }),
        ]),
      ),
    );
  }
}
