import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Vacation {
  final String vac_id;
  final String reason;
  final String startdate;
  final String enddate;

  Vacation({
    @required this.vac_id,
    @required this.reason,
    @required this.startdate,
    @required this.enddate,
  });
}

class Vacations with ChangeNotifier {
  List<Vacation> _vacations = [];
  final String authToken;
  final String user_id;

  Vacations(this._vacations, this.authToken, this.user_id);

  List<Vacation> get vacations {
    return [..._vacations];
  }

  Vacation findById(String id) {
    return _vacations.firstWhere((vacation) => vacation.vac_id == id);
  }

  Future<void> fetchAndSetVacations(String user_id) async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/v1/users/unavailabilities/$user_id');
    final response = await http.get(url);
    final decoded_response = json.decode(response.body);
    final int number_of_objects = decoded_response.length;
    print(user_id);
    print(authToken);
    print(response.body.length);
    final List<Vacation> loadedEvent = [];
    final extractedData = json.decode(response.body);
    // print(extractedData["name"]);
    if (extractedData == null) {
      return;
    }
    // extractedData.forEach((eventId, eventData) {
    int i = 0;
    while (i < number_of_objects) {
      loadedEvent.add(Vacation(
        vac_id: extractedData[i]['avail_id'],
        reason: extractedData[i]['reason'],
        startdate: extractedData[i]['startdate'],
        enddate: extractedData[i]['enddate'],
      ));
      i++;
    }

    _vacations = loadedEvent.reversed.toList();
    notifyListeners();
  }

  Future<void> addVacation(Vacation vacation, String user_id) async {
    final url = Uri.parse(
        'http://10.0.2.2:8000/api/v1/users/unavailabilities/$user_id');
    // var uuid = Uuid();
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            'vac_id': vacation.vac_id,
            'reason': vacation.reason,
            'startdate': vacation.startdate,
            'enddate': vacation.enddate,
          }));
      print(json.decode(response.body));
      final newVacation = Vacation(
        // event_id: json.decode(response.body)['event_id'],
        vac_id: json.decode(response.body)['vac_id'],
        reason: vacation.reason,
        startdate: vacation.startdate,
        enddate: vacation.enddate,
      );
      _vacations.add(newVacation);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  // void addVacation(Vacation vacation) {
  //   final newVacation = Vacation(
  //     vac_id: DateTime.now().toString(),
  //     reason: vacation.reason,
  //     startdate: vacation.startdate,
  //     enddate: vacation.enddate,
  //   );
  //   _vacations.add(newVacation);
  //   notifyListeners();
  // }

  void updateProduct(String id, Vacation newVacation) {
    final vacIndex = _vacations.indexWhere((vac) => vac.vac_id == id);
    if (vacIndex >= 0) {
      _vacations[vacIndex] = newVacation;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteVacation(String id) {
    _vacations.removeWhere((vac) => vac.vac_id == id);
    notifyListeners();
  }
}
