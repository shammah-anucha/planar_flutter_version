import 'package:flutter/material.dart';

class PlanarTitle extends StatelessWidget {
  const PlanarTitle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: EdgeInsets.only(top: 50.0),
        color: Colors.white,
        child: Text(
          'Planar',
          style: TextStyle(
              fontSize: 45,
              color: Colors.cyan[800],
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
