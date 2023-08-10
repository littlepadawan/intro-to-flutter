import 'package:intl/intl.dart';

import '../utilities/capitalize.dart';
import '../utilities/round_double.dart';
import 'location_data.dart';

class WeatherData {
  double? latitude;
  double? longitude;
  String? city;
  String? country;
  String? date;
  String? description;
  String? icon;
  double? temperature;
  int? feelsLike;
  String? sunrise;
  String? sunset;
  String? lastUpdate;
  int? windSpeed;
  int? windGust;

  WeatherData({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
    required this.date,
    required this.description,
    required this.icon,
    required this.temperature,
    required this.feelsLike,
    required this.sunrise,
    required this.sunset,
    required this.lastUpdate,
    required this.windSpeed,
    required this.windGust,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json, double latitude,
      double longitude, LocationData locationData) {
    DateTime today = DateTime.now();
    return WeatherData(
      latitude: latitude,
      longitude: longitude,
      city: json['name'],
      country: locationData.country,
      date:
          '${DateFormat('E').format(today)}, ${DateFormat('MMMd').format(today)}, ${DateFormat('y').format(today)}',
      description: capitalize(json['weather'][0]['description']),
      icon: json['weather'][0]['icon'],
      temperature: roundToOneDecimal(json['main']['temp']),
      feelsLike: json['main']['feels_like'].round(),
      sunrise: DateFormat.jm().format(
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000)),
      sunset: DateFormat.jm().format(
          DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)),
      lastUpdate: DateFormat.jm()
          .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
      windSpeed: json['wind']['speed']?.round(),
      windGust: json['wind']['gust']?.round(),
    );
  }
}
