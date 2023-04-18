import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:planar_fluteer_version/screen/admin/create_event.dart';
import 'package:provider/provider.dart';

class EditEventItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  EditEventItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                CreateEventScreen.routeName,
                arguments: id,
              );
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {
              Provider.of<Events>(context, listen: false).deleteEvent(id);
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          )
        ]),
      ),
    );
  }
}
