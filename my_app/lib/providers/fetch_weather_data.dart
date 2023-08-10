import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_data.dart';
import '../models/location_data.dart';

Future<WeatherData> fetchWeatherData(double latitude, double longitude) async {
  String stringLatitude = latitude.toString();
  String stringLongitude = longitude.toString();
  String url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$stringLatitude&lon=$stringLongitude&appid=5430333b2b984d9cf3d533524975465e&units=metric';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to load JSON data. ${response.statusCode}');
  }

  final locationData =
      await ReverseGeocodingService().getGeolocationData(latitude, longitude);
  WeatherData weatherData = WeatherData.fromJson(
      json.decode(response.body), latitude, longitude, locationData);
  return weatherData;
}
