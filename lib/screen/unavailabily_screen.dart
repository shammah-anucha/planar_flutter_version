import 'package:flutter/material.dart';
import '../widgets/new_vacation.dart';
import '../widgets/vacations_list.dart';
import '../models/vacation.dart';
import '../widgets/navbar.dart';

class UnavailabilityScreen extends StatefulWidget {
  static const routeName = '/unavailability';

  @override
  State<UnavailabilityScreen> createState() => _UnavailabilityScreenState();
}

class _UnavailabilityScreenState extends State<UnavailabilityScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final List<Vacation> _userVacations = [];

  void _addNewVacation(
    String vacReason,
    String chosenStartDate,
    String chosenEndDate,
  ) {
    final newVac = Vacation(
      id: DateTime.now().toString(),
      reason: vacReason,
      startdate: chosenStartDate,
      enddate: chosenEndDate,
    );

    setState(() {
      _userVacations.add(newVac);
    });
  }

  void _deleteVacation(String id) {
    setState(() {
      _userVacations.removeWhere((vc) => vc.id == id);
    });
  }

  //   @override
  // void initState() {
  //   _pages = [
  //     {'page': UnavailabilityScreen(), 'title': 'Vacations'},
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Vacation'),
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              if (_scaffoldkey.currentState.isDrawerOpen == false) {
                _scaffoldkey.currentState.openDrawer();
              } else {
                _scaffoldkey.currentState.openEndDrawer();
              }
            },
          ),
        ),
        body: Scaffold(
          key: _scaffoldkey,
          drawer: NavBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // height: 550,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'My Vacation Days',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(height: 20),
                      NewVacation(_addNewVacation),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: VacationList(_userVacations, _deleteVacation),
                ),
              ],
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
            backgroundColor: Theme.of(context).accentColor,
          ),
        ));
  }
}
