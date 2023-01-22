import 'package:flutter/material.dart';

class Vacation {
  final String id;
  final String reason;
  final String startdate;
  final String enddate;

  Vacation({
    @required this.id,
    @required this.reason,
    @required this.startdate,
    @required this.enddate,
  });
}
