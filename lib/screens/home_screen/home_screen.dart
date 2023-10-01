import 'package:flutter/material.dart';
import 'package:weather_app/components/hour_forecast/hour_forecast.dart';
import 'package:weather_app/config/SizeConfig.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    WeatherService weatherService = WeatherService();
    String getTimeString(time) {
      DateTime date = DateTime.parse(time);
      return "${date.hour > 9 ? date.hour.toString() : '0' + date.hour.toString()}:${date.minute > 9 ? date.minute.toString() : '0' + date.minute.toString()}";
    }

    return Scaffold(
      appBar: AppBar(
        actions: const [Icon(Icons.add_circle_rounded)],
        centerTitle: true,
        title: const Text(
          "Weather App",
        ),
        leading: const Icon(Icons.dehaze_rounded),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: weatherService.getCurrentWeather("Paris"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final data = snapshot.data;
                  // Use the API data to build your UI
                  // return Text('API Data: ${data}');
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          // "Katowice"
                          data?['location']['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 48, fontWeight: FontWeight.w500)),
                      Text("Today",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 28, color: Colors.grey)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                            // "2℃"
                            "${data?['current']['temp_c']}℃",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 84,
                              color: Colors.blue[800],
                              // decoration: TextDecoration.underline,
                              // decorationStyle: TextDecorationStyle.solid,
                              // decorationThickness: 0.5,
                              // decorationColor: Colors.grey
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Text(
                            // "Sunny"
                            data?['current']['condition']['text'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28, color: Colors.grey)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              "${data?['forecast']['forecastday'][0]['day']['mintemp_c']}℃",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue)),
                          const Text("/",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 24, color: Colors.grey)),
                          Text(
                              "${data?['forecast']['forecastday'][0]['day']['maxtemp_c']}℃",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 24, color: Colors.blue[800])),
                        ],
                      ),
                      Text(
                          'API Data: ${data?['forecast']['forecastday'][0]['hour'][0]}'),
                      Container(
                          width: SizeConfig.width - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Forecast for today",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: List.generate(
                                      data?['forecast']['forecastday'][0]
                                              ['hour']
                                          .length,
                                      (index) {
                                        // Create and return a widget for each item in dynamicData
                                        return HourForecast(
                                          time: getTimeString(data?['forecast']
                                                  ['forecastday'][0]['hour']
                                              [index]['time']),
                                          forecast: data?['forecast']
                                                  ['forecastday'][0]['hour']
                                              [index]['condition']['icon'],
                                          temperature: data?['forecast']
                                                  ['forecastday'][0]['hour']
                                              [index]['temp_c'],
                                          windSpeed: data?['forecast']
                                                  ['forecastday'][0]['hour']
                                              [index]['wind_kph'],
                                          precipitate: data?['forecast']
                                                      ['forecastday'][0]['hour']
                                                  [index]['humidity']
                                              .toDouble(),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
