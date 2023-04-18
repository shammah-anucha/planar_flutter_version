import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:planar_fluteer_version/widgets/home_item.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/admin';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Dashboard',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(),
              ListTile(
                title: Text('Create Event'),
                onTap: (() {
                  Navigator.of(context).pushNamed('/admin-events');
                }),
              ),
              Divider(),
              ListTile(
                title: Text('Create User'),
                onTap: (() {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ),
              Divider(),
              ListTile(
                title: Text('Assign Event to User'),
                onTap: (() {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ),
              Divider(),
              ListTile(
                title: Text('Create Department'),
                onTap: (() {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ),
              Divider(),
              ListTile(
                title: Text('Assign Department to User'),
                onTap: (() {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ),
              Divider(),
              ListTile(
                title: Text('Create Roster'),
                onTap: (() {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
              ),
            ],
          ),
        ),
        drawer: NavBar(),
      ),
    );
  }
}
