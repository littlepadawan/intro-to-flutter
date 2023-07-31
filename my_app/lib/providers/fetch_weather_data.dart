import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchWeatherData() async {
  const url =
      'https://api.openweathermap.org/data/2.5/weather?q=Visby&appid=5430333b2b984d9cf3d533524975465e';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode != 200) {
    throw Exception('Failed to load JSON data');
  }
  return json.decode(response.body).toString();
}
