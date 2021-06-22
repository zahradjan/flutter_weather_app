import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class EarthScreen extends StatefulWidget {
  @override
  _EarthScreenState createState() => _EarthScreenState();
}

class _EarthScreenState extends State<EarthScreen> {
  Position position;

  _EarthScreenState();

  var currentWeather;
  var historicWeather;
  var hwHourly;

  Future getCurrentWeather(Position position) async {
    String apiKey = "7d7eb0c393fc786be48641a6a0e08dd1";
    var lat = position.latitude;
    var lon = position.longitude;
    var url =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&lang=cz&appid=$apiKey&units=metric";

    final response = await http.get(url);

    currentWeather = jsonDecode(response.body);

    return currentWeather;
  }

  String getDateFromTimestamp(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat("dd.MM.yyyy hh:mm");
    return formatter.format(date);
  }

  String getDateFromTimestampToMonthAndDay(int timestamp) {
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var formatter = new DateFormat("dd.MM.yyyy");
    return formatter.format(date);
  }

  Future getHistoricWeather(Position position) async {
    String apiKey = "7d7eb0c393fc786be48641a6a0e08dd1";

    var lat = position.latitude;
    var lon = position.longitude;
    var testTime =
        (DateTime.now().millisecondsSinceEpoch / 1000).toStringAsFixed(0);

    print(testTime);

    var url =
        "https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$lat&lon=$lon&dt=$testTime&appid=$apiKey&units=metric";

    final response = await http.get(url);

    historicWeather = jsonDecode(response.body);
    hwHourly = historicWeather["hourly"];

    return historicWeather;
  }

  Future getWeather() async {
    position = await getLocation();
    await getCurrentWeather(position);
    await getHistoricWeather(position);
  }

  Widget listItem(String date, double temp) {
    var tempFixed = temp.toStringAsFixed(0);
    return Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Text(
                "$date",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Avg: $tempFixed°C",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 120,
            ),
            Expanded(
              child: Text(
                "",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 2.0,
          width: double.infinity,
          color: Colors.white,
        )
      ],
    );
  }

  Future getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getWeather(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (currentWeather == null || hwHourly == null) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/earth-landscape.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  colorFilter:
                      ColorFilter.mode(Colors.black54, BlendMode.darken),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.lightGreenAccent),
                    )
                  ],
                ),
              ),
            );
          } else {
            var currentWDate =
                getDateFromTimestampToMonthAndDay(currentWeather["dt"]);
            final minTempOC =
                (currentWeather["main"]["temp_min"]).toStringAsFixed(0);
            final maxTempOC =
                (currentWeather["main"]["temp_max"]).toStringAsFixed(0);
            final tempOC = (currentWeather["main"]["temp"]).toStringAsFixed(0);

            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/earth-landscape.jpg"),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    colorFilter:
                        ColorFilter.mode(Colors.black54, BlendMode.darken),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Temperature\nat ${(currentWeather["name"])}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 28.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "$currentWDate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "High: $maxTempOC°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Avg: $tempOC°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Low:  $minTempOC°C",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60.0,
                      ),
                      Text(
                        "Average hourly",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 28.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 3.0,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: hwHourly.length,
                            itemBuilder: (BuildContext, int index) {
                              var hourlyDate =
                                  getDateFromTimestamp((hwHourly[index]["dt"]));
                              return listItem(
                                  (hourlyDate), (hwHourly[index]["temp"]));
                            }),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        });
  }
}
