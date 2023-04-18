import 'package:flutter/material.dart';
import '../providers/events.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:provider/provider.dart';
import '../widgets/event_item.dart';

class UpComingEventScreen extends StatefulWidget {
  static const routeName = '/upcoming-events';

  @override
  State<UpComingEventScreen> createState() => _UpComingEventScreenState();
}

class _UpComingEventScreenState extends State<UpComingEventScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.items;
    // final eventId = ModalRoute.of(context).settings.arguments as String;
    // final loadedProduct =
    //     Provider.of<Events>(context, listen: false).findById(eventId);
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
          drawer: NavBar(),
          body: ListView.builder(
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: events[i],
              child: EventItem(),
            ),
            itemCount: events.length,

            // events
            //     .map((e) => EventItem(
            //         e.id, e.imageUrl, e.title, e.location, e.eventdate))
            //     .toList(),
            // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            //   maxCrossAxisExtent: 400,
            //   childAspectRatio: 3 / 2,
            //   crossAxisSpacing: 20,
            //   mainAxisSpacing: 20,
            // ),
          ),
        ));
  }
}
