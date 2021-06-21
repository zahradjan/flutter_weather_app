import 'package:flutter/material.dart';

class EarthWeather extends StatefulWidget {
  final List weather;
  EarthWeather(List weather) : this.weather = weather;
  @override
  _EarthWeatherState createState() => _EarthWeatherState(weather);
}

class _EarthWeatherState extends State<EarthWeather> {
  List weather;
  _EarthWeatherState(List weather) : this.weather = weather;

  @override
  Widget build(BuildContext context) {
    print(weather);
    // return Container();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/earth-landscape.jpg"),
            fit: BoxFit.cover,
            alignment: Alignment.center,
            colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 15, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Latest Weather\nat Gale Crater",
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
                      "Sol ${(weather[0]["name"])}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "High: ${(weather[0]["main"]["temp_max"])}°C",
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
                      "${(weather[0]["main"]["temp"])}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Low: ${(weather[0]["main"]["temp_min"])}°C",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // SizedBox(
    //             height: 60.0,
    //           ),
    //           Text(
    //             "Previous Days",
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.w800,
    //               fontSize: 28.0,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10.0,
    //           ),
    //           Container(
    //             height: 3.0,
    //             width: double.infinity,
    //             color: Colors.white,
    //           ),
    //           Expanded(
    //             child: ListView.builder(
    //                 itemCount: solKey.length,
    //                 itemBuilder: (BuildContext, int index) {
    //                   return listItem(
    //                       (solKey[index]["sol"]),
    //                       (weatherData[index]["min_temp"]),
    //                       (weatherData[index]["max_temp"]),
    //                       (weatherData[index]["terrestrial_date"]));
    //                 }),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
