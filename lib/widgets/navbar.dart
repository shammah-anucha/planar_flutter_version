import 'package:flutter/material.dart';
import '../screen/calendar_screen.dart';
import '../screen/home_screen.dart';
import '../screen/inbox_screen.dart';
import '../screen/logout_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/roster_screen.dart';
import '../screen/setting_screen.dart';
import '../screen/unavailabily_screen.dart';
import '../screen/upcoming_events_screen.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  Widget buildListTile(String title, Function tapHandler) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
      // hoverColor: Colors.grey[300],
      title: Text(title),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          buildListTile('Home', () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          buildListTile('Roster', () {
            Navigator.of(context).pushReplacementNamed(RosterScreen.routeName);
          }),
          buildListTile('Unavailability', () {
            Navigator.of(context)
                .pushReplacementNamed(UnavailabilityScreen.routeName);
          }),
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
          SizedBox(
            height: 250,
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
