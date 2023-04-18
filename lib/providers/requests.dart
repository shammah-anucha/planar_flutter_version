import 'package:flutter/material.dart';
import 'request.dart';

class Requests with ChangeNotifier {
  List<Request> _requests = [
    Request(
        id: 'r1',
        title: "Beach Party- 11:00",
        eventdate: DateTime.now(),
        role: "Costume Designer"),
    Request(
      id: 'r2',
      title: "Hang Out",
      eventdate: DateTime.now(),
      role: "Usher",
    ),
    Request(
        id: 'r3',
        title: "Face Painting",
        eventdate: DateTime.now(),
        role: "Artist"),
  ];
  List<Request> get items {
    return [..._requests];
  }

  Request findById(String id) {
    return _requests.firstWhere((request) => request.id == id);
  }
}
