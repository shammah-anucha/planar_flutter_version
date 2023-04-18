import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/providers/request.dart';
import 'package:provider/provider.dart';

class RosterItem extends StatefulWidget {
  @override
  State<RosterItem> createState() => _RosterItemState();
}

class _RosterItemState extends State<RosterItem> {
  @override
  Widget build(BuildContext context) {
    final request = Provider.of<Request>(context, listen: false);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          color: Colors.teal[100],
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMEd().format(request.eventdate).toString(),
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
              request.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor),
            ),
            TextButton(onPressed: () {}, child: Text('Other Volunteers'))
          ],
        ),
        Text(request.role,
            style: TextStyle(color: Theme.of(context).accentColor))
      ]),
    );
  }
}
