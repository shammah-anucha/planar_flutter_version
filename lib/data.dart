import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './models/request.dart';
import './models/events.dart';

final List<Request> requests = [
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

final List<Events> events = [
  Events(
    id: 'e1',
    title: "Beach Party",
    eventdate: DateTime.now(),
    imageUrl:
        "https://images.pexels.com/photos/40815/youth-active-jump-happy-40815.jpeg",
    location: "Am Friedrichschain 25",
    host: "Beautiful People",
    tags: ["fun", "games", "beach"],
  ),
  Events(
      id: 'e2',
      title: "Hang Out",
      eventdate: DateTime.now(),
      imageUrl:
          "https://images.pexels.com/photos/708440/pexels-photo-708440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      location: "Warshauerstr 25",
      host: "Pop Music",
      tags: ["outdoors", "meeting", "fun"]),
  Events(
      id: 'e3',
      title: "Face Painting",
      eventdate: DateTime.now(),
      imageUrl:
          "https://images.pexels.com/photos/904276/pexels-photo-904276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      location: "Friedrichstr 25",
      host: "Art Culture",
      tags: ["painting", "art", "wine"]),
];
