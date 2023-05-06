import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/events.dart';
import 'package:planar_fluteer_version/widgets/navbar.dart';
import 'package:planar_fluteer_version/widgets/home_item.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  bool _showOnlyFavorites = false;
  var _isInit = false;
  var _isLoading = false;

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });
    _isLoading = true;
    Provider.of<Events>(context, listen: false).fetchAndSetEvents().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventsData = Provider.of<Events>(context);
    final events = eventsData.items;
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
              Expanded(
                child: ListView.builder(
                    itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                          value: events[i],
                          child: HomeItem(),
                        ),
                    itemCount: events.length),
              )
            ],
          ),
        ),
        drawer: NavBar(),
      ),
    );
  }
}
