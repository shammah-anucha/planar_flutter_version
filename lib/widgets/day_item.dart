import 'package:flutter/material.dart';

class DayItem extends StatefulWidget {
  final String title;
  final String date;

  DayItem(this.title, this.date);

  @override
  State<DayItem> createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  Color _gridColor = Colors.cyan[100];
  bool _isChecked = false;

  Future<void> showMyDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              // backgroundColor: Colors.cyan[50],
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                ),
                height: 70,
                // color: Colors.cyan[50],
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      widget.title + " " + widget.date,
                      style: TextStyle(color: Colors.teal[800], fontSize: 18),
                    ),
                  ],
                ),
              ),
              content: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        // groupValue: isChecked,
                        onChanged: (checked) {
                          setState(() {
                            _isChecked = checked;
                          });
                        },
                      ),
                      Text(
                        "Unavailable",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                new ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Confirm'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).accentColor),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMyDialog(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Text(widget.title,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 5,
          ),
          Text(widget.date,
              style: TextStyle(color: Colors.black54, fontSize: 14))
        ]),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _isChecked
                  ? Colors.redAccent.withOpacity(0.7)
                  : _gridColor.withOpacity(0.7),
              _isChecked ? Colors.redAccent : _gridColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
