import 'package:flutter/material.dart';

class Event with ChangeNotifier {
  final String id;
  final String title;
  final String eventdate;
  final String time;
  final String imageUrl;
  final String location;
  final String location_url;
  final String host;
  final List<String> tags;

  Event({
    @required this.id,
    @required this.title,
    @required this.eventdate,
    @required this.time,
    @required this.imageUrl,
    @required this.location,
    @required this.host,
    @required this.location_url,
    this.tags,
  });
}
