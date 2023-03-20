import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/screen/event_detail.dart';
import 'package:planar_fluteer_version/screen/singleday_screen.dart';
import '../screen/calendar_screen.dart';
import '../screen/home_screen.dart';
import '../screen/inbox_screen.dart';
import '../screen/logout_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/roster_screen.dart';
import '../screen/setting_screen.dart';
import 'screen/vacation_screen.dart';
import '../screen/upcoming_events_screen.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomePage',
      theme: ThemeData(
          primaryColor: Colors.cyan[600],
          accentColor: Colors.cyan[800],
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(color: Colors.grey[600]),
              bodyText2: TextStyle(color: Colors.grey[600]),
              headline6: TextStyle(fontSize: 20))),
      home: HomeScreen(),
      // initialRoute: '/home',
      routes: {
        // '/': (ctx) => HomeScreen(),
        RosterScreen.routeName: (ctx) => RosterScreen(),
        EventDetailScreen.routeName: (ctx) => EventDetailScreen(),
        VacationsScreen.routeName: (ctx) => VacationsScreen(),
        SingleDayScreen.routeName: (ctx) => SingleDayScreen(),
        UpComingEventScreen.routeName: (ctx) => UpComingEventScreen(),
        CalendarScreen.routeName: (ctx) => CalendarScreen(),
        InboxScreen.routeName: (ctx) => InboxScreen(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
        LogoutScreen.routeName: (ctx) => LogoutScreen(),
        SettingsScreen.routeName: (ctx) => SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        // return MaterialPageRoute(
        //   builder: (ctx) => CategoriesScreen(),
        // );
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );
      },
    );
  }
}


// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//    GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey();
//   final List<Vacation> _userVacations = [];

//   void _addNewVacation(
//     String vacReason,
//     String chosenStartDate,
//     String chosenEndDate,
//   ) {
//     final newVac = Vacation(
//       id: DateTime.now().toString(),
//       reason: vacReason,
//       startdate: chosenStartDate,
//       enddate: chosenEndDate,
//     );

//     setState(() {
//       _userVacations.add(newVac);
//     });
//   }

//   // final appName = "Planar App";

//   // final dateLabel = "DD/MM/YYYY";

//   void _deleteVacation(String id) {
//     setState(() {
//       _userVacations.removeWhere((vc) => vc.id == id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Planar App',
//       theme: ThemeData(
//         primaryColor: Colors.cyan[700],
//         accentColor: Colors.cyan[800],
//         // primaryColor: Color.fromRGBO(81, 157, 153, 1),
//         // accentColor: Color.fromRGBO(54, 115, 111, 1),
//         errorColor: Colors.redAccent,
//         textTheme: ThemeData.light().textTheme.copyWith(
//               bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
//               bodyText2: TextStyle(
//                 color: Color.fromRGBO(20, 51, 51, 1),
//               ),
//               headline6: TextStyle(
//                   fontSize: 20,
//                   // fontFamily: 'RobotoCondensed',
//                   fontWeight: FontWeight.bold),
//             ),
//         appBarTheme: AppBarTheme(
//           titleTextStyle: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
      
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
 

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
          
//           title: 'Planar App',
//           theme: ThemeData(
//         primaryColor: Colors.cyan[700],
//         accentColor: Colors.cyan[800],
//         // primaryColor: Color.fromRGBO(81, 157, 153, 1),
//         // accentColor: Color.fromRGBO(54, 115, 111, 1),
//         errorColor: Colors.redAccent,
//         textTheme: ThemeData.light().textTheme.copyWith(
//               bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
//               bodyText2: TextStyle(
//                 color: Color.fromRGBO(20, 51, 51, 1),
//               ),
//               headline6: TextStyle(
//                   fontSize: 20,
//                   // fontFamily: 'RobotoCondensed',
//                   fontWeight: FontWeight.bold),
//             ),
//           leading: IconButton(
//             icon: Icon(Icons.dehaze),
//             onPressed: () {
//               if (_scaffoldkey.currentState.isDrawerOpen == false) {
//                 _scaffoldkey.currentState.openDrawer();
//               } else {
//                 _scaffoldkey.currentState.openEndDrawer();
//               }
//             },
//           ),
//         ),
//         body: Scaffold(
//           key: _scaffoldkey,
//           drawer: NavBar(),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   // height: 550,
//                   margin: EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'My Vacation Days',
//                         style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Theme.of(context).primaryColor),
//                       ),
//                       SizedBox(height: 20),
//                       NewVacation(_addNewVacation),
//                       SizedBox(
//                         height: 50,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: VacationList(_userVacations, _deleteVacation),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {},
//           backgroundColor: Theme.of(context).accentColor,
//         ),
//       ),
//       initialRoute: '/',
//       routes: {
//         HomeScreen.routeName: (ctx) => HomeScreen(),
//         RosterScreen.routeName: (ctx) => RosterScreen(),
//         UnavailabilityScreen.routeName: (ctx) => UnavailabilityScreen(),
//         UpComingEventScreen.routeName: (ctx) => UpComingEventScreen(),
//         CalendarScreen.routeName: (ctx) => CalendarScreen(),
//         InboxScreen.routeName: (ctx) => InboxScreen(),
//         ProfileScreen.routeName: (ctx) => ProfileScreen(),
//         LogoutScreen.routeName: (ctx) => LogoutScreen(),
//         SettingsScreen.routeName: (ctx) => SettingsScreen(),
//       },
//       onGenerateRoute: (settings) {
//         print(settings.arguments);
//         // return MaterialPageRoute(
//         //   builder: (ctx) => CategoriesScreen(),
//         // );
//       },
//       onUnknownRoute: (settings) {
//         return MaterialPageRoute(
//           builder: (ctx) => HomeScreen(),
//         );
//       },
//     );
//   }
// }
