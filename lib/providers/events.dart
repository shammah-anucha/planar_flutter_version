import 'package:flutter/material.dart';
import 'event.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    Event(
      id: 'e1',
      title: "Beach Party",
      eventdate: DateTime.now().toString(),
      imageUrl:
          "https://images.pexels.com/photos/40815/youth-active-jump-happy-40815.jpeg",
      location: "Am Friedrichschain 25",
      host: "Beautiful People",
      tags: ["fun", "games", "beach"],
    ),
    Event(
        id: 'e2',
        title: "Hang Out",
        eventdate: DateTime.now().toString(),
        imageUrl:
            "https://images.pexels.com/photos/708440/pexels-photo-708440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        location: "Warshauerstr 25",
        host: "Pop Music",
        tags: ["outdoors", "meeting", "fun"]),
    Event(
        id: 'e3',
        title: "Face Painting",
        eventdate: DateTime.now().toString(),
        imageUrl:
            "https://images.pexels.com/photos/904276/pexels-photo-904276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        location: "Friedrichstr 25",
        host: "Art Culture",
        tags: ["painting", "art", "wine"]),
  ];

  List<Event> get items {
    return [..._events];
  }

  Event findById(String id) {
    return _events.firstWhere((event) => event.id == id);
  }

  void addEvent(Event event) {
    final newEvent = Event(
      id: DateTime.now().toString(),
      title: event.title,
      eventdate: event.eventdate,
      imageUrl: event.imageUrl,
      location: event.location,
      location_url: event.location_url,
      host: event.host,
      tags: event.tags,
    );
    _events.add(newEvent);
    notifyListeners();
  }

  void updateEvent(String id, Event newEvent) {
    final evIndex = _events.indexWhere((ev) => ev.id == id);
    if (evIndex >= 0) {
      _events[evIndex] = newEvent;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteEvent(String id) {
    _events.removeWhere((ev) => ev.id == id);
    notifyListeners();
  }
}
