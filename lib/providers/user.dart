import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String user_id;
  final String firstname;
  final String lastname;
  final String email;
  final String dob;
  // final String nationality;
  final String phone;
  final String password;

  User(
      {@required this.user_id,
      @required this.firstname,
      @required this.lastname,
      @required this.email,
      @required this.dob,
      // @required this.nationality,
      @required this.phone,
      @required this.password});
}
