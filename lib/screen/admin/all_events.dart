import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:planar_fluteer_version/screen/admin/create_event.dart';
import 'package:planar_fluteer_version/widgets/admin/edit_event_item.dart';
import 'package:provider/provider.dart';

class AdminEventsScreen extends StatelessWidget {
  static const routeName = '/admin-events';

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(CreateEventScreen.routeName);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, i) => Column(
            children: [
              EditEventItem(eventsData.items[i].id, eventsData.items[i].title,
                  eventsData.items[i].imageUrl),
              Divider(),
            ],
          ),
          itemCount: eventsData.items.length,
        ),
      ),
    );
  }
}
