import 'package:flutter/material.dart';
import 'package:planar_fluteer_version/providers/auth.dart';
import 'package:planar_fluteer_version/providers/user.dart';
import 'package:planar_fluteer_version/providers/users.dart';
import 'package:planar_fluteer_version/screen/home_screen.dart';
import 'package:planar_fluteer_version/screen/login_screen.dart';
import 'package:intl/intl.dart';
import '../widgets/planar_title.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../screen/roster_screen.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();
  TextEditingController _selectedDate = TextEditingController();

  var _editedUser = User(
    user_id: '',
    firstname: '',
    lastname: '',
    email: '',
    dob: '',
    phone: '',
    password: '',
  );
  var _initValues = {
    'user_id': '',
    'firstname': '',
    'lastname': '',
    'email': '',
    'dob': '',
    'phone': '',
    'password': '',
  };
  var _isInit = true;
  var _isLoading = false;
  // Map<String, String> _authData = {
  //   'username': '',
  //   'password': '',
  // };

  @override
  void didChangeDependencies() {
    if (_isInit && context != null) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      if (userId != null) {
        _editedUser =
            Provider.of<Users>(context, listen: false).findById(userId);
        _initValues = {
          'firstname': _editedUser.firstname,
          'lastname': _editedUser.lastname,
          'email': _editedUser.email,
          'dob': _editedUser.dob,
          'phone': _editedUser.phone,
          'password': _editedUser.password,
        };
        _selectedDate.text = _editedUser.dob.toString();
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> addUser(User user) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/v1/users/{user_id}');
    var uuid = Uuid();
    try {
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            // 'user_id': uuid.v4(),
            'firstname': user.firstname,
            'lastname': user.lastname,
            'email': user.email,
            'dob': user.dob,
            'phone': user.phone,
            'password': user.password,
          }));
      // print(json.decode(response.body));
      final newUser = User(
        user_id: json.decode(response.body)['user_id'],
        firstname: user.firstname,
        lastname: user.lastname,
        email: user.email,
        dob: user.dob,
        phone: user.phone,
        password: user.password,
      );
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        print('Sign Up Failed');
        print(json.decode(response.body));
      }

      // }
    } catch (error) {
      // print(error);
      // print(error);
      throw (error);
    }
  }

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      addUser(_editedUser);
    } catch (error) {
      throw (error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((pickedEventDate) {
      if (pickedEventDate == null) {
        return;
      } else {
        String _formattedEventDate =
            DateFormat('yyyy-MM-dd').format(pickedEventDate);
        print(_formattedEventDate);

        setState(() {
          _selectedDate.text = _formattedEventDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          // width: deviceSize.width * 0.75,
          height: 1000,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  PlanarTitle(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        initialValue: _initValues['firstname'],
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your first name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: value,
                            lastname: _editedUser.lastname,
                            email: _editedUser.email,
                            dob: _editedUser.dob,
                            phone: _editedUser.phone,
                            password: _editedUser.password,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        initialValue: _initValues['lastname'],
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your last name!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: _editedUser.firstname,
                            lastname: value,
                            email: _editedUser.email,
                            dob: _editedUser.dob,
                            phone: _editedUser.phone,
                            password: _editedUser.password,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        initialValue: _initValues['email'],
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: _editedUser.firstname,
                            lastname: _editedUser.lastname,
                            email: value,
                            dob: _editedUser.dob,
                            phone: _editedUser.phone,
                            password: _editedUser.password,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        initialValue: _initValues['phone'],
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phonenumber!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: _editedUser.firstname,
                            lastname: _editedUser.lastname,
                            email: _editedUser.email,
                            dob: _editedUser.dob,
                            phone: value,
                            password: _editedUser.password,
                          );
                        }),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        controller: _selectedDate,
                        decoration: InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_month,
                              color: Colors.cyan[800]),
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a date';
                          }
                          return null;
                        },
                        onTap: _presentDatePicker,
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: _editedUser.firstname,
                            lastname: _editedUser.lastname,
                            email: _editedUser.email,
                            dob: value,
                            phone: _editedUser.phone,
                            password: _editedUser.password,
                          );
                        }),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 5.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       labelText: 'Nationality',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'Please enter your nationality!';
                  //       }
                  //       return null;
                  //     },
                  //     // onSaved: (value) {
                  //     //   _authData['email'] = value;
                  //     // },
                  //   ),
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 5.0),
                  //   child: TextFormField(
                  //     decoration: InputDecoration(
                  //       labelText: 'Country of Residence',
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     validator: (value) {
                  //       if (value.isEmpty) {
                  //         return 'Please enter your country of residence!';
                  //       }
                  //       return null;
                  //     },
                  //     // onSaved: (value) {
                  //     //   _authData['email'] = value;
                  //     // },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                        // initialValue: _initValues['password'],
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        obscureText: true,
                        controller: _passwordController,
                        validator: (value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                        },
                        onSaved: (value) {
                          _editedUser = User(
                            firstname: _editedUser.firstname,
                            lastname: _editedUser.lastname,
                            email: _editedUser.email,
                            dob: _editedUser.dob,
                            phone: _editedUser.phone,
                            password: value,
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: TextFormField(
                      // initialValue: _initValues['password'],
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: Text('SIGN UP'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan[800]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    child: Text(
                      'Already Have an Account? LogIn!',
                      style: TextStyle(color: Colors.cyan[800]),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(AuthScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
