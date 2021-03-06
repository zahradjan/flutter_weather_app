import 'package:flutter/material.dart';

import 'package:weather_app/screens/earth_screen.dart';
import 'package:weather_app/screens/mars_screen.dart';
import 'package:weather_app/widgets/planet_widget.dart';

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Temperature App',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Which planet are you on?',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => EarthScreen()))
                  },
              child: Planet('Earth', 'assets/images/earth-icon.png')),
          GestureDetector(
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => MarsScreen()))
            },
            child: Planet('Mars', 'assets/images/mars-icon.png'),
          ),
        ],
      ),
    );
  }
}
