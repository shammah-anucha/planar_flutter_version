import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/vacation.dart';

class VacationList extends StatelessWidget {
  // final List<Vacation> vacations;
  // final Function deleteVc;

  // VacationList(this.vacations, this.deleteVc);

  @override
  Widget build(BuildContext context) {
    final vacationsData = Provider.of<Vacations>(context);
    final vacations = vacationsData.vacations;
    return Container(
      height: 1000,
      child: vacations.isEmpty
          ? Text(
              'No Vacations Added',
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
                        onPressed: () => vacationsData
                            .deleteVacation(vacations[index].vac_id)),
                  ),
                );
              }),
            ),
    );
  }
}
