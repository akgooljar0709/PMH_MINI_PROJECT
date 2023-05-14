import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new/DashboardPage.dart';

import 'package:flutter_new/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fetch_data.dart';
import 'package:image/image.dart' as img;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Screen',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Auth _auth = Auth();

  Future<void> _login() async {
    String email = _usernameController.text;
    String password = _passwordController.text;

    try {
      // Sign in the user with the provided credentials
      await _auth.signInWithEmailandPassword(email, password);

      // Navigate to the dashboard on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    } catch (e) {
      // Display an error message to the user if login fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  Future<void> _register() async {
    String email = _usernameController.text;
    String password = _passwordController.text;

    try {
      // Register the user with the provided credentials
      await _auth.registerWithEmailandPassword(email, password);

      // Display a success message to the user
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Successful'),
          content: Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Display an error message to the user if registration fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Registration Error'),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login Screen'),
        ),
        body: Container(
        padding: EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Image.asset(
    'assets/images/login_image.png',
    width: 200,
    height: 200,
    ),
    SizedBox(height: 20.0),
    TextFormField(
    controller: _usernameController,
    decoration: InputDecoration(
    hintText: 'Email',
    ),
    ),
    SizedBox(height: 20.0),
    TextFormField(
    controller: _passwordController,
    obscureText: true,
    decoration: InputDecoration(
    hintText: 'Password',
    ),
    ),
    SizedBox(height: 20.0),
    ElevatedButton(
    onPressed: _login,
    child: Text('Login'),
    ),
    SizedBox(height: 20.0),
      ElevatedButton(
        onPressed: _register,
        child: Text('Register'),
      ),
    ],
    ),
        ),
    );
  }
}
