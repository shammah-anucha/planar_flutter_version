import 'package:flutter/material.dart';

class Days {
  final String title;
  Color color;
  DateTime date;

  Days({
    @required this.title,
    @required this.color,
    this.date,
  });
}
