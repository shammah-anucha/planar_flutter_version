import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../widgets/planar_title.dart';
import '../models/http_exception.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.white,
        ),
        SingleChildScrollView(
          child: Container(
            height: 900,
            width: deviceSize.width,
            child: Column(children: [
              PlanarTitle(),
              Flexible(
                child: Container(
                  height: deviceSize.height * 0.4,
                  child: Center(
                    child: Image.asset('assets/pics/IMG_1893.jpg'),
                  ),
                ),
              ),
              Flexible(
                flex: deviceSize.width > 800 ? 2 : 1,
                child: AuthCard(),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordController = TextEditingController();

  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };
  var _isLoading = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('Okay'))
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).login(
        _authData['username'],
        _authData['password'],
      );
    }
    // on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email address is already in use.';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email address';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak.';
    //   } else if (error.toString().contains('Incorrect email or password')) {
    //     errorMessage = 'Could not find a user with that email';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'Invalid password';
    //   }
    //   _showErrorDialog(errorMessage);
    catch (error) {
      const errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // return LayoutBuilder(builder: (ctx, constraints) {
    //   return Column(
    //     children: [
    //       SizedBox(
    //         height: 50,
    //       ),

    //       // Divider(),

    //       SizedBox(
    //         height: 5,
    //       ),
    return Material(
      child: Container(
        color: Colors.white,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-Mail',
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
                  _authData['username'] = value;
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
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
                  _authData['password'] = value;
                },
              ),
              // if (_authMode == AuthMode.Signup)
              //   TextFormField(
              //     // enabled: _authMode == AuthMode.Signup,
              //     decoration: InputDecoration(labelText: 'Confirm Password'),
              //     obscureText: true,
              //     validator: _authMode == AuthMode.Signup
              //         ? (value) {
              //             if (value != _passwordController.text) {
              //               return 'Passwords do not match!';
              //             }
              //           }
              //         : null,
              //   ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(
                      'Forgot your Password?',
                    ),
                    onPressed: null,
                  ),
                ],
              ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _submit,
                  child: Text('LOGIN'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[800]),
                ),
              SizedBox(
                height: 5,
              ),
              TextButton(
                child: Text(
                  'No Account? Join the Community!',
                  style: TextStyle(color: Colors.cyan[800]),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
