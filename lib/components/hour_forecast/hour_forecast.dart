import 'package:flutter/material.dart';
import 'package:weather_app/config/SizeConfig.dart';

class HourForecast extends StatefulWidget {
  String time;
  String forecast;
  double temperature;
  double windSpeed;
  double precipitate;
  HourForecast({
    super.key,
    required this.time,
    required this.forecast,
    required this.temperature,
    required this.windSpeed,
    required this.precipitate,
  });

  @override
  State<HourForecast> createState() => _HourForecastState();
}

class _HourForecastState extends State<HourForecast> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          Text(
            widget.time,
            style: TextStyle(color: Colors.black),
          ),
          // Icon(
          //   widget.forecast == "sunny"
          //       ? Icons.sunny
          //       : widget.forecast == "cloudy"
          //           ? Icons.cloud
          //           : widget.forecast == "rain"
          //               ? Icons.water_drop_outlined
          //               : Icons.cloudy_snowing,
          //   size: SizeConfig.getProportionalWidth(8),
          // ),
          Image(
            image: NetworkImage('https:' + widget.forecast),
            width: SizeConfig.getProportionalWidth(10),
          ),
          Text(
            "${widget.temperature}℃",
            style: TextStyle(color: Colors.black),
          ),
          Icon(
            Icons.waves_rounded,
            size: SizeConfig.getProportionalWidth(8),
            color: Colors.grey[600],
          ),
          Text(
            "${widget.windSpeed} km/h",
            style: TextStyle(color: Colors.grey[600]),
          ),
          Icon(Icons.water_drop_rounded,
              size: SizeConfig.getProportionalWidth(8),
              color: Colors.blue[600]),
          Text(
            "${widget.precipitate}%",
            style: TextStyle(color: Colors.blue[600]),
          ),
        ],
      ),
    );
  }
}
