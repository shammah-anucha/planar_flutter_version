import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/requests.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:planar_fluteer_version/widgets/inbox_item.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  static const routeName = '/inbox';

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final requestsData = Provider.of<Requests>(context);
    final requests = requestsData.items;
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
            Expanded(
              child: ListView.builder(
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                        value: requests[i],
                        child: InboxItem(),
                      ),
                  itemCount: requests.length),
            ),
          ]),
          drawer: NavBar(),
        ));
  }
}
