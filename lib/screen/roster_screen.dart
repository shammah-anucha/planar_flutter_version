import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/models/request.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:intl/intl.dart';
import '../data.dart';

class RosterScreen extends StatelessWidget {
  static const routeName = '/roster';

  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final requestId =
    //     ModalRoute.of(context).settings.arguments as Map<String, String>;
    // final selectedRequest = requests.map((request) => request.id == requestId);
    return Scaffold(
      appBar: AppBar(
        title: Text('Roster'),
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
        body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.teal[100],
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat.yMMMEd()
                                  .format(requests[index].eventdate)
                                  .toString(),
                              style: TextStyle(color: Colors.teal[800]),
                            ),
                            Icon(
                              Icons.edit,
                              size: 10,
                              color: Theme.of(context).accentColor,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            requests[index].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                          TextButton(
                              onPressed: null, child: Text('Other Volunteers'))
                        ],
                      ),
                      Text(requests[index].role,
                          style:
                              TextStyle(color: Theme.of(context).accentColor))
                    ]),
              );
            },
            itemCount: requests.length),
      ),
    );
  }
}
