import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planar_fluteer_version/widgets/popup.dart';
import '../screen/singleday_screen.dart';

class DayItem extends StatefulWidget {
  final String title;
  final Color color;

  DayItem(this.title, this.color);

  @override
  State<DayItem> createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  // void selectCategory(BuildContext ctx) {

  Future<void> showMyDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
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
                      DateFormat.yMMMEd().format(DateTime.now()).toString(),
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
                          value: isChecked,
                          // groupValue: isChecked,
                          onChanged: (checked) {
                            setState(() {
                              isChecked = checked;
                            });
                          }),
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
        child: Text(widget.title, style: Theme.of(context).textTheme.headline6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [widget.color.withOpacity(0.7), widget.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
