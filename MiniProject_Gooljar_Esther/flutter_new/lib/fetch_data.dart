import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class TemperatureList extends StatefulWidget {
  @override
  _TemperatureListState createState() => _TemperatureListState();
}

class _TemperatureListState extends State<TemperatureList> {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/1.jpeg',
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: StreamBuilder(
                  stream: databaseReference.child('temperature').onValue,
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        !snapshot.hasError &&
                        snapshot.data!.snapshot.value != null) {
                      var temperature =
                      double.parse(snapshot.data!.snapshot.value.toString());
                      Color textColor = Colors.black;
                      if (temperature > 29) {
                        textColor = Colors.red;
                      }
                      if (temperature > 20 && temperature <= 29) {
                        textColor = Colors.orange;
                      }
                      if (temperature >= 15 && temperature <= 20) {
                        textColor = Colors.lightGreen;
                      }
                      if (temperature < 15) {
                        textColor = Colors.blue;
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.thermostat_outlined, size: 24),
                              SizedBox(width: 10),
                              Text(
                                'Temperature:',
                                style: TextStyle(fontSize: 24),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            '$temperature °C',
                            style: TextStyle(fontSize: 32, color: textColor),
                          ),
                          SizedBox(height: 40),
                          StreamBuilder(
                            stream: databaseReference.child('turbidity').onValue,
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  !snapshot.hasError &&
                                  snapshot.data!.snapshot.value != null) {
                                var turbidity =
                                double.parse(snapshot.data!.snapshot.value.toString());
                                Color turbidityColor = turbidity > 15 ? Colors.red : Colors.black;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.opacity_outlined, size: 24),
                                        SizedBox(width: 10),
                                        Text(
                                          'Turbidity:',
                                          style: TextStyle(fontSize: 24),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '$turbidity NTU',
                                      style: TextStyle(fontSize: 32, color: turbidityColor),
                                    ),
                                  ],
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Real Time Temperature and Turbidity Data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
