import 'package:flutter/material.dart';
import 'package:planar_flutter_version/models/vacation.dart';
import 'package:planar_flutter_version/widgets/new_vacation.dart';
import './widgets/vacations_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // final MaterialColor mycolor = MaterialColor(
  //   0XFF519D99,
  //   <int, Color>{
  //     50: Color(0XFF519D99),
  //     100: Color(0XFF36736F),
  //   },
  // );
  // final Color myaccenColor = Color(0XFF36736F);
  // Color.fromRGBO(81,157, 153, 1)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planar App',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(81, 157, 153, 1),
        // accentColor: Color.fromRGBO(54, 115, 111, 1),
        errorColor: Colors.redAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  // final appName = "Planar App";

  // final dateLabel = "DD/MM/YYYY";

  void _deleteVacation(String id) {
    setState(() {
      _userVacations.removeWhere((vc) => vc.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Planar App'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
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
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
