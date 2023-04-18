import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/providers/request.dart';
import 'package:provider/provider.dart';

class InboxItem extends StatefulWidget {
  @override
  State<InboxItem> createState() => _InboxItemState();
}

class _InboxItemState extends State<InboxItem> {
  @override
  Widget build(BuildContext context) {
    final request = Provider.of<Request>(context, listen: false);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
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
              Text(DateFormat.yMMMEd().format(request.eventdate).toString()),
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
      )
    ]);
  }
}
