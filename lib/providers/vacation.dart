import 'package:flutter/material.dart';

class Vacation {
  final String id;
  final String reason;
  final String startdate;
  final String enddate;

  Vacation({
    @required this.id,
    @required this.reason,
    @required this.startdate,
    @required this.enddate,
  });
}

class Vacations with ChangeNotifier {
  List<Vacation> _vacations = [];

  List<Vacation> get items {
    return [..._vacations];
  }

  Vacation findById(String id) {
    return _vacations.firstWhere((vacation) => vacation.id == id);
  }

  void addVacation(Vacation vacation) {
    final newVacation = Vacation(
      id: DateTime.now().toString(),
      reason: vacation.reason,
      startdate: vacation.startdate,
      enddate: vacation.enddate,
    );
    _vacations.add(newVacation);
    notifyListeners();
  }

  void updateProduct(String id, Vacation newVacation) {
    final vacIndex = _vacations.indexWhere((prod) => prod.id == id);
    if (vacIndex >= 0) {
      _vacations[vacIndex] = newVacation;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteVacation(String id) {
    _vacations.removeWhere((vac) => vac.id == id);
    notifyListeners();
  }
}
