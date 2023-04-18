import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Request with ChangeNotifier {
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
