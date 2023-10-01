import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getCurrentWeather(query) async {
    // Current Day Api
    // https://api.weatherapi.com/v1/current.json?key=b2f17386084b489e9dc62304232309&q=London&aqi=no
    // Forecast Api
    // https://api.weatherapi.com/v1/forecast.json?key=b2f17386084b489e9dc62304232309&q=Karachi&days=1&aqi=no&alerts=yes
    var url = Uri.https('api.weatherapi.com', '/v1/forecast.json', {
      'key': 'b2f17386084b489e9dc62304232309',
      'q': query,
      'days': '1',
      'aqi': 'no',
      'alerts': 'yes'
    });

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      print('Respoanse: $jsonResponse.');
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      throw Exception('Failed to load data');
    }
  }
}
