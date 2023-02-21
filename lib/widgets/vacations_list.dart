import 'package:flutter/material.dart';
import '../models/vacation.dart';
import 'package:intl/intl.dart';

class VacationList extends StatelessWidget {
  final List<Vacation> vacations;
  final Function deleteVc;

  VacationList(this.vacations, this.deleteVc);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      child: vacations.isEmpty
          ? Text(
              'Nothing to Display',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            )
          : ListView.builder(
              itemCount: vacations.length,
              itemBuilder: ((context, index) {
                return Card(
                  // margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      vacations[index].reason,
                      style: TextStyle(
                        color: Color.fromRGBO(81, 157, 153, 1),
                        // Color.fromRGBO(81, 157, 153, 1)
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text((vacations[index].startdate)),
                        Text('until'),
                        Text((vacations[index].enddate)),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.redAccent,
                      onPressed: () => deleteVc(
                        vacations[1].id.toString(),
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}


// Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Card(
//                     elevation: 5,
//                     child: Container(
//                       height: 50,
//                       width: 275,
//                       margin: EdgeInsets.all(10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             'Christmas Holiday',
//                             style: TextStyle(
//                               color: Color.fromRGBO(81, 157, 153, 1),
//                               // Color.fromRGBO(81, 157, 153, 1)
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('20/01/2023'),
//                               Text('until'),
//                               Text('20/02/2023'),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     color: Colors.redAccent,
//                     onPressed: () {},
//                   ),
//                 ],
//               );


// ListView.builder(itemBuilder: ((context, index) {
//               return Card(
//                 margin: EdgeInsets.all(10),
//                 elevation: 5,
//                 child: ListTile(
//                   title: Text(
//                     '${vacations[index].reason}',
//                     style: TextStyle(
//                       color: Color.fromRGBO(81, 157, 153, 1),
//                       // Color.fromRGBO(81, 157, 153, 1)
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(DateFormat.yMMMd()
//                           .format(vacations[index].startdate)),
//                       Text('until'),
//                       Text(DateFormat.yMMMd().format(vacations[index].enddate)),
//                     ],
//                   ),
//                   trailing: IconButton(
//                     icon: Icon(Icons.delete),
//                     color: Colors.redAccent,
//                     onPressed: () => deleteVc(
//                       vacations[index].id,
//                     ),
//                   ),
//                 ),
//               );
//             })),