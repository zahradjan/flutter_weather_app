import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/screens/init_screen.dart';
import 'package:weather_app/widgets/earth_weather.dart';

class EarthScreen extends StatefulWidget {
  Position _currentPosition;
  String _currentAddress;

  final Geolocator geolocator = Geolocator();
  // _getCurrentLocation() {
  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //     _getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // _getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //     Placemark place = p[0];
  //     setState(() {
  //       _currentAddress =
  //           "${place.locality}, ${place.postalCode}, ${place.country}";
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future getCurrentWeather(Location location) async {
    Weather weather;
    String city = location.city;
    String apiKey = "7d7eb0c393fc786be48641a6a0e08dd1";
    var url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final response = await http.get(url);

    if (response.statusCode == 200) {
      weather = Weather.fromJson(jsonDecode(response.body));
    }

    return weather;
  }

  // Future getForecast(Location location) async {
  //   Forecast forecast;
  //   String apiKey = "e08e24f8a96e8e84de3ac9b675d32489";
  //   String lat = location.lat;
  //   String lon = location.lon;
  //   var url =
  //       "https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     forecast = Forecast.fromJson(jsonDecode(response.body));
  //   }

  //   return forecast;
  // }

  @override
  _EarthScreenState createState() => _EarthScreenState();
}

class _EarthScreenState extends State<EarthScreen> {
  Position position;
  var weather = [];
  void getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  Future getCurrentWeather(var position) async {
    print(position);

    // String city = position.city;
    String apiKey = "7d7eb0c393fc786be48641a6a0e08dd1";
    var lat = position.latitude;
    var lon = position.longitude;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric";

    final response = await http.get(url);
    print(response.body);
    if (response.statusCode == 200) {
      weather = jsonDecode(response.body);
    }

    return weather;
  }

  @override
  void initState() {
    this.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    print(weather);
    return FutureBuilder(
        future: this.getCurrentWeather(this.position),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return EarthWeather(weather);
          } else {
            return CircularProgressIndicator();
          }
        });
    // this.getData();
  }
}
