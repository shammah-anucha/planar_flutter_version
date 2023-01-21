import 'package:flutter/material.dart';
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
          accentColor: Color.fromRGBO(54, 115, 111, 1),
          errorColor: Colors.redAccent,
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                color: Color.fromRGBO(81, 157, 153, 1),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          appBarTheme: AppBarTheme(
              titleTextStyle:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final appName = "Planar App";

  final dateLabel = "DD/MM/YYYY";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(appName),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 480,
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
                    Text(
                      'Start date',
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: dateLabel,
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onSubmitted: (value) {},
                      ),
                    ),
                    Text(
                      'End date',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: dateLabel,
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.calendar_month,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        onSubmitted: (value) {},
                      ),
                    ),
                    Text(
                      'Reason',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Container(
                      child: Expanded(
                        child: TextField(
                          maxLength: 250,
                          expands: true,
                          maxLines: null,
                          onSubmitted: (value) {},
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: null,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text('See all...'),
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    VacationList(),
                    VacationList(),
                    VacationList(),
                  ],
                ),
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
