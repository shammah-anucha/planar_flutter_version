import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import '../data.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'What\'s Coming Up',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: events.map((event) {
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Column(
                      children: [
                        Card(
                            child: Image.network(
                          event.imageUrl,
                          height: 150,
                        )),
                        Text(
                          event.title,
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        drawer: NavBar(),
      ),
    );
  }
}
