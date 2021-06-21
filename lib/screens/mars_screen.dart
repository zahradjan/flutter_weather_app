// import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MarsScreen extends StatefulWidget {
  @override
  _MarsScreenState createState() => _MarsScreenState();
}

class _MarsScreenState extends State<MarsScreen> {
  var encodedUrl = Uri.encodeFull(
      "https://mars.nasa.gov/rss/api/?feed=weather&category=msl&feedtype=json");

  var solKey = [];
  var data;
  var toCelsius = 33.8;
  List weatherData = [];

  Future getData() async {
    http.Response response = await http.get(
      encodedUrl,
      headers: {"Accept": "application/json"},
    );
    setState(() {
      // print(url);
      // print(encodedUrl);
      data = json.decode(response.body);
      // print(data);
      solKey = data["soles"];
      // print(solKey.length);

      solKey = solKey.toList();
      weatherData = solKey.toList();
    });
  }

  Widget listItem(String sol, String min, String max, String date) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    var dateParse = dateFormat.parse(date);

    var dateFormatted = DateFormat('dd.MM.yyyy').format(dateParse);
    return Column(
      children: [
        SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Text(
                "Sol $sol",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              width: 120,
            ),
            Expanded(
              child: Text(
                "High: $max°C",
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
        Row(
          children: [
            Expanded(
              child: Text(
                "$dateFormatted",
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
                "Low: $min°C",
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

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // this.getData();
    return FutureBuilder(
        future: this.getData(),
        builder: (context, snapshot) {
          if (solKey.length > 0) {
            final minTempOC =
                (double.parse(weatherData[0]["min_temp"]) + toCelsius)
                    .toStringAsFixed(0);
            final maxTempOC =
                (double.parse(weatherData[0]["max_temp"]) + toCelsius)
                    .toStringAsFixed(0);
            return Scaffold(
                body: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mars-landscape.jpg"),
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
                      "Latest Temperature\nat Gale Crater",
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
                            "Sol ${solKey[0]["sol"]}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38.0,
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
                            "${(weatherData[0]["season"])}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Low: $minTempOC°C",
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
                      "Previous Days",
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
                          itemCount: solKey.length,
                          itemBuilder: (BuildContext, int index) {
                            final minTempC =
                                (double.parse(weatherData[index]["min_temp"]) +
                                        toCelsius)
                                    .toStringAsFixed(0);
                            final maxTempC =
                                (double.parse(weatherData[index]["max_temp"]) +
                                        toCelsius)
                                    .toStringAsFixed(0);
                            return listItem(
                                (solKey[index]["sol"]),
                                minTempC,
                                maxTempC,
                                (weatherData[index]["terrestrial_date"]));
                          }),
                    )
                  ],
                ),
              ),
            ));
          } else {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mars-landscape.jpg"),
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
                          Colors.deepOrangeAccent),
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
