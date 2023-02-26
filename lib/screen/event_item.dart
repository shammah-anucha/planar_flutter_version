import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/screen/event_detail.dart';

class EventItem extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String title;
  final String location;
  final DateTime eventdate;

  EventItem(this.id, this.imageUrl, this.title, this.location, this.eventdate);

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  void _selectedPage() {
    setState(() {
      Navigator.of(context)
          .pushNamed(EventDetailScreen.routeName, arguments: widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: _selectedPage,
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    child: Image.network(
                      widget.imageUrl,
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
                        widget.title,
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
                  widget.title,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                Text(
                  DateFormat.jm().format(widget.eventdate).toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
                Text(
                  DateFormat.yMMMMEEEEd().format(widget.eventdate).toString(),
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 12),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.location,
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
