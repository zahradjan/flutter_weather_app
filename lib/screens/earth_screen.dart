import 'package:flutter/material.dart';

class EarthScreen extends StatefulWidget {
  @override
  _EarthScreenState createState() => _EarthScreenState();
}

class _EarthScreenState extends State<EarthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/earth-landscape.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken)),
        ),
      ),
    );
  }
}
