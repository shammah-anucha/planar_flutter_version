import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/models/request.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:intl/intl.dart';
import '../data.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox';

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inbox'),
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
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Respond to Requests',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // SizedBox(height: 2),
            Column(
                children: requests.map((request) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  title: Text(
                    request.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(request.role),
                      Text(DateFormat.yMMMEd()
                          .format(request.eventdate)
                          .toString()),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: null,
                              child: Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.green,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: null,
                              child: Text('Decline',
                                  style: TextStyle(color: Colors.white)),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList())
          ]),
          drawer: NavBar(),
        ));
  }
}
