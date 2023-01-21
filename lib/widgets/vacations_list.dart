import 'package:flutter/material.dart';

class VacationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          elevation: 5,
          child: Container(
            height: 50,
            width: 275,
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Christmas Holiday',
                  style: TextStyle(
                    color: Color.fromRGBO(81, 157, 153, 1),
                    // Color.fromRGBO(81, 157, 153, 1)
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('20/01/2023'),
                    Text('until'),
                    Text('20/02/2023'),
                  ],
                ),
              ],
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Colors.redAccent,
          onPressed: () {},
        ),
      ],
    );
  }
}
