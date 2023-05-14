import 'package:flutter/material.dart';
import 'fetch_data.dart';
import 'auth.dart';
import 'main.dart';
import 'location.dart';

// Import the LoginPage class

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final Auth _auth = Auth();

  int _currentIndex = 0;

  List<Widget> _pages = [
    TemperatureList(),
    location(),
  ];

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Navigate to LoginPage
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 2) { // If logout is selected
            _logout(); // Call logout function
          } else {
            setState(() => _currentIndex = index); // Switch tabs
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Temperature',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Location',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Log Out',
          ),
        ],
      ),
    );
  }
}
