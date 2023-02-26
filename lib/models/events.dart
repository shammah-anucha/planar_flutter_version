import 'package:flutter/material.dart';

class Events {
  final String id;
  final String title;
  final DateTime eventdate;
  final String imageUrl;
  final String location;
  final String host;
  final List<String> tags;

  Events({
    @required this.id,
    @required this.title,
    @required this.eventdate,
    @required this.imageUrl,
    @required this.location,
    @required this.host,
    this.tags,
  });
}
