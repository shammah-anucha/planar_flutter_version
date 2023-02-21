import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';

class UpComingEventScreen extends StatefulWidget {
  static const routeName = '/upcoming-events';

  @override
  State<UpComingEventScreen> createState() => _UpComingEventScreenState();
}

class _UpComingEventScreenState extends State<UpComingEventScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('UpComing Events'),
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
          body: Center(child: Text('This is the Upcoming Events page')),
          drawer: NavBar(),
        ));
  }
}
