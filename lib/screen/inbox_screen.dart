import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/models/request.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox';

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final List<Request> requests = [
    Request(
        id: 'r1',
        title: "Beach Party- 11:00",
        eventdate: DateTime.now(),
        role: "Custome Designer"),
    Request(
        id: 'r2', title: "Hang Out", eventdate: DateTime.now(), role: "Usher"),
    Request(
        id: 'r3',
        title: "Face Painting",
        eventdate: DateTime.now(),
        role: "Artist"),
  ];
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
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
              child: Text(
                'Respond to Requests',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 25),
            Column(
                children: requests.map((request) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
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
                      Text(request.eventdate.toString()),
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
