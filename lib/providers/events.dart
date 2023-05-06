import 'package:flutter/material.dart';
import 'event.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/http_exception.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    // Event(
    //   event_id: 'e1',
    //   title: "Beach Party",
    //   eventdate: DateTime.now().toString(),
    //   imageUrl:
    //       "https://images.pexels.com/photos/40815/youth-active-jump-happy-40815.jpeg",
    //   location: "Am Friedrichschain 25",
    //   host: "Beautiful People",
    // ),
    // Event(
    //   event_id: 'e2',
    //   title: "Hang Out",
    //   eventdate: DateTime.now().toString(),
    //   imageUrl:
    //       "https://images.pexels.com/photos/708440/pexels-photo-708440.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    //   location: "Warshauerstr 25",
    //   host: "Pop Music",
    //   // tags: ["outdoors", "meeting", "fun"]
    // ),
    // Event(
    //   event_id: 'e3',
    //   title: "Face Painting",
    //   eventdate: DateTime.now().toString(),
    //   imageUrl:
    //       "https://images.pexels.com/photos/904276/pexels-photo-904276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    //   location: "Friedrichstr 25",
    //   host: "Art Culture",
    //   // tags: ["painting", "art", "wine"]
    // ),
  ];

  List<Event> get items {
    return [..._events];
  }

  Event findById(String id) {
    return _events.firstWhere((event) => event.event_id == id);
  }

  Future<void> fetchAndSetEvents() async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/events/');
    final response = await http.get(url);
    final decoded_response = json.decode(response.body);
    final int number_of_objects = decoded_response.length;
    print(json.decode(response.body));
    print(response.body.length);
    final List<Event> loadedEvent = [];
    final extractedData = json.decode(response.body);
    // print(extractedData["name"]);
    if (extractedData == null) {
      return;
    }
    // extractedData.forEach((eventId, eventData) {
    int i = 0;
    while (i < number_of_objects) {
      loadedEvent.add(Event(
        event_id: extractedData[i]['event_id'],
        title: extractedData[i]['title'],
        eventdate: extractedData[i]['eventdate'],
        time: extractedData[i]['time'],
        imageUrl: extractedData[i]['imageUrl'],
        location: extractedData[i]['location'],
        location_url: extractedData[i]['location_url'],
        host: extractedData[i]['host'],
      ));
      i++;
    }

    _events = loadedEvent.reversed.toList();
    notifyListeners();
  }

  // final String baseUrl = "http://127.0.0.1:8000/api/v1/events/";

  // void _fetchDataFromTheServer() async {
  //   final Dio dio = Dio();
  // }

// http://127.0.0.1:8000/api/v1/events/
  Future<void> addEvent(Event event) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/events/{event_id}');
    var uuid = Uuid();
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            // 'event_id': uuid.v4(),
            'title': event.title,
            'eventdate': event.eventdate,
            'time': event.time,
            'imageUrl': event.imageUrl,
            'location': event.location,
            'location_url': event.location_url,
            'host': event.host,
          }));
      print(json.decode(response.body));
      final newEvent = Event(
        event_id: json.decode(response.body)['event_id'],
        title: event.title,
        eventdate: event.eventdate,
        time: event.time,
        imageUrl: event.imageUrl,
        location: event.location,
        location_url: event.location_url,
        host: event.host,
      );
      _events.add(newEvent);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> updateEvent(String id, Event newEvent) async {
    final evIndex = _events.indexWhere((ev) => ev.event_id == id);
    final event_id = _events[evIndex].event_id;
    if (evIndex != null) {
      final url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$event_id');
      await http.put(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'title': newEvent.title,
            'eventdate': newEvent.eventdate,
            'time': newEvent.time,
            'imageUrl': newEvent.imageUrl,
            'location': newEvent.location,
            'location_url': newEvent.location_url,
            'host': newEvent.host
          }));
      print(event_id);
      _events[evIndex] = newEvent;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteEvent(String id) async {
    final evIndex = _events.indexWhere((ev) => ev.event_id == id);
    final event_id = _events[evIndex].event_id;
    var existingEvent = _events[evIndex];
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/events/$event_id');
    _events.removeAt(evIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _events.insert(evIndex, existingEvent);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingEvent = null;
  }
}
