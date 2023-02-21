import 'package:flutter/material.dart';

class Request {
  final String id;
  final String title;
  final String role;
  final DateTime eventdate;

  Request({
    @required this.id,
    @required this.title,
    @required this.role,
    @required this.eventdate,
  });
}
