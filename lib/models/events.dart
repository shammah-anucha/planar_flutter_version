import 'package:flutter/material.dart';

class Events {
  final String id;
  final String title;
  final DateTime eventdate;
  final String imageUrl;

  Events({
    @required this.id,
    @required this.title,
    @required this.eventdate,
    @required this.imageUrl,
  });
}
