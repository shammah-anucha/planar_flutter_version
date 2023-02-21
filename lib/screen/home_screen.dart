import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/models/events.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  final List<Events> events = [
    Events(
        id: 'e1',
        title: "Beach Party",
        eventdate: DateTime.now(),
        imageUrl:
            "https://images.pexels.com/photos/40815/youth-active-jump-happy-40815.jpeg"),
    Events(
        id: 'e2',
        title: "Hang Out",
        eventdate: DateTime.now(),
        imageUrl:
            "https://images.pexels.com/photos/708440/pexels-photo-708440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Events(
        id: 'e3',
        title: "Face Painting",
        eventdate: DateTime.now(),
        imageUrl:
            "https://images.pexels.com/photos/904276/pexels-photo-904276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  ];

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

// ListView.builder(
//               itemCount: events.length,
//               itemBuilder: ((context, index) {
//                 return Card(
//                       child: Image.network(
//                     events[index].imageUrl,
//                     height: 150,
//                   ));
//               }),
//             ),