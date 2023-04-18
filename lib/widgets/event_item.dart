import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/providers/event.dart';
import 'package:planar_fluteer_version/screen/event_detail.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget {
  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<Event>(context, listen: false);
    return Container(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: (() {
            setState(() {
              Navigator.of(context)
                  .pushNamed(EventDetailScreen.routeName, arguments: event.id);
            });
          }),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      event.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 20,
                    child: Container(
                      width: 100,
                      color: Colors.black54,
                      child: Text(
                        event.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                Text(
                  event.title,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Text(
                  DateFormat.jm().format(event.eventdate).toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
                Text(
                  DateFormat.yMMMMEEEEd().format(event.eventdate).toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.location,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        fontSize: 12),
                  ),
                  TextButton(
                      onPressed: (() => null),
                      child: Text('Joint Event',
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 12,
                          ))),
                ],
              ),
            ],
          ),
        ));
  }
}
