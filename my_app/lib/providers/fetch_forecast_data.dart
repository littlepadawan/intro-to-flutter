import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/forecast_data.dart';
import '../models/location_data.dart';

Future<ForecastData> fetchForecastData(
    double latitude, double longitude) async {
  String stringLatitude = latitude.toString();
  String stringLongitude = longitude.toString();
  String url =
      'https://api.openweathermap.org/data/2.5/forecast?lat=$stringLatitude&lon=$stringLongitude&appid=5430333b2b984d9cf3d533524975465e&units=metric';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to load JSON data');
  }

  final locationData =
      await ReverseGeocodingService().getGeolocationData(latitude, longitude);
  ForecastData forecastData = ForecastData.fromJson(
      json.decode(response.body), latitude, longitude, locationData);
  return forecastData;
}
