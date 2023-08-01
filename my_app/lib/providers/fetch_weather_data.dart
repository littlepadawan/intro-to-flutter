import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/models/weather_data.dart';

Future<WeatherData> fetchWeatherData(String latitude, String longitude) async {
  String url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=5430333b2b984d9cf3d533524975465e&units=metric';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to load JSON data');
  }

  WeatherData weatherData = WeatherData.fromJson(json.decode(response.body));
  return weatherData;
}
