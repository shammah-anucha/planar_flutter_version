import 'package:flutter/material.dart';
import '../providers/requests.dart';
import '../widgets/navbar.dart';
import '../widgets/roster_item.dart';
import 'package:provider/provider.dart';

class RosterScreen extends StatelessWidget {
  static const routeName = '/roster';

  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final request = Provider.of<Request>(context, listen: false);
    final requestsData = Provider.of<Requests>(context);
    final requests = requestsData.items;
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
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: requests[i],
                  child: RosterItem(),
                ),
            itemCount: requests.length),
      ),
    );
  }
}
