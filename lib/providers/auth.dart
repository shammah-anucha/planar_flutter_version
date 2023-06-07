import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  // DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuth {
    print(token != null);
    return token != null;
  }

  String get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }

  String get user_id {
    if (_userId != null) {
      return _userId;
    }
    return null;
  }

  Future<String> _authenticate(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/login/');

    try {
      final response = await http.post(url,
          body: json.encode({
            'username': email,
            'password': password,
            'access_token': true,
          }),
          headers: {'Content-Type': 'application/json'});
      final responseData = json.decode(response.body);
      // print(responseData);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse['access_token'];
        print('Logged in successfully with access token: $accessToken');
        // Store the access token securely in the app for future use
      } else {
        HttpException(responseData);
      }
      _token = responseData['access_token'];
      _userId = responseData['user_id'];
      print(_token);
      print(_userId);
      // _autoLogout();
      notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode({
      //   'token': _token,
      //   'userId': _userId,
      //   'expiryDate': _expiryDate.toIso8601String(),
      // });
      // prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<String> _register(String email) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/register/');

    try {
      final response = await http.post(url,
          body: json.encode({
            'username': email,
            'access_token': true,
          }),
          headers: {'Content-Type': 'application/json'});
      final responseData = json.decode(response.body);
      // print(responseData);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final accessToken = jsonResponse['access_token'];
        print('Logged in successfully with access token: $accessToken');
        // Store the access token securely in the app for future use
      } else {
        HttpException(responseData);
      }
      _token = responseData['access_token'];
      print(_token);
      // _autoLogout();
      notifyListeners();
      // final prefs = await SharedPreferences.getInstance();
      // final userData = json.encode({
      //   'token': _token,
      //   'userId': _userId,
      //   'expiryDate': _expiryDate.toIso8601String(),
      // });
      // prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _register(email);
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  // Future<bool> tryAutoLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('userData')) {
  //     return false;
  //   }
  //   final extractedUserData =
  //       json.decode(prefs.getString('userData')) as Map<String, Object>;
  //   final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

  //   if (expiryDate.isBefore(DateTime.now())) {
  //     return false;
  //   }

  //   _token = extractedUserData['token'];
  //   _userId = extractedUserData['userId'];
  //   _expiryDate = expiryDate;
  //   notifyListeners();
  //   _autoLogout();
  //   return true;
  // }

  void logout() async {
    _token = null;
    _userId = null;
    // _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    // final prefs = await SharedPreferences.getInstance();
    // To be used if you have more than the user data stored in the sharedpreferences
    // prefs.remove('userData');
    // prefs.clear();
  }

//   void _autoLogout() {
//     if (_authTimer != null) {
//       _authTimer.cancel();
//     }
//     final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
//     _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
//   }
}
