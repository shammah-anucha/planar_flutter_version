// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:planar_fluteer_version/widgets/day_item.dart';

// class UnavailabilityPopUp extends StatefulWidget {
//   @override
//   State<UnavailabilityPopUp> createState() => _UnavailabilityPopUpState();
// }

// class _UnavailabilityPopUpState extends State<UnavailabilityPopUp> {
//   // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   Future<void> showMyDialog(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         builder: (context) {
//           bool isChecked = false;
//           return StatefulBuilder(builder: (context, setState) {
//             return AlertDialog(
//               // backgroundColor: Colors.cyan[50],
//               title: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.cyan[50],
//                 ),
//                 height: 70,
//                 // color: Colors.cyan[50],
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Text(
//                       DateFormat.yMMMEd().format(DateTime.now()).toString(),
//                       style: TextStyle(color: Colors.teal[800], fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//               content: new Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Radio(
//                           value: isChecked,
//                           onChanged: (checked) {
//                             setState(() {
//                               isChecked = checked;
//                             });
//                           }),
//                       Text(
//                         "Unavailable",
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               actions: <Widget>[
//                 new ElevatedButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text('Confirm'),
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Theme.of(context).accentColor),
//                 ),
//               ],
//             );
//           });
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return null;
//   }
// }
