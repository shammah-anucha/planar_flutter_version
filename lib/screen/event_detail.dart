import 'dart:math';

import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:intl/intl.dart';
// import '../data.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  static const routeName = '/event-details';

  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventId = ModalRoute.of(context).settings.arguments as String;
    final selectedEvent =
        Provider.of<Events>(context, listen: false).findById(eventId);
    // final eventId = ModalRoute.of(context).settings.arguments as String;
    // final selectedEvent = events.firstWhere((event) => event.id == eventId);
    final String extract_tags = selectedEvent.tags.reduce((value, element) {
      return value + ', ' + element;
    });

    Widget buildSectionTitle(BuildContext context, String title, String text) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            Text(text)
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(selectedEvent.title),
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
          body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(selectedEvent.imageUrl),
                buildSectionTitle(context, 'Time: ',
                    DateFormat.jm().format(selectedEvent.eventdate).toString()),
                buildSectionTitle(
                    context,
                    'Date: ',
                    DateFormat.yMMMMEEEEd()
                        .format(selectedEvent.eventdate)
                        .toString()),
                buildSectionTitle(
                    context, 'Location: ', selectedEvent.location),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text('Description',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  textAlign: TextAlign.justify,
                ),
                buildSectionTitle(context, 'Organizer: ', selectedEvent.host),
                buildSectionTitle(context, 'Tags: ', extract_tags),
                ElevatedButton(
                    onPressed: null,
                    child: Text(
                      'Request Join',
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor))
              ],
            ),
          ),
          drawer: NavBar(),
        ));
  }
}
