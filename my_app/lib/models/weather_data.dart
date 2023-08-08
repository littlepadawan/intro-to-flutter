import 'package:intl/intl.dart';
import 'package:my_app/utilities/capitalize.dart';
import 'package:my_app/utilities/round_double.dart';
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
  String? lastUpdate;

  WeatherData(
      {required this.latitude,
      required this.longitude,
      required this.city,
      required this.country,
      required this.date,
      required this.description,
      required this.icon,
      required this.temperature,
      required this.lastUpdate});

  factory WeatherData.fromJson(Map<String, dynamic> json, double latitude,
      double longitude, LocationData locationData) {
    //TODO get time of data fetch

    DateTime today = DateTime.now();
    return WeatherData(
      latitude: latitude,
      longitude: longitude,
      city: json['name'], // TODO: error handling since func is depracated?
      country: locationData.country,
      // weekday: getWeekdayAsString(today.weekday),
      date:
          '${DateFormat('E').format(today)}, ${DateFormat('MMMd').format(today)}, ${DateFormat('y').format(today)}',
      description: capitalize(json['weather'][0]['description']),
      icon: json['weather'][0]['icon'],
      temperature: roundToOneDecimal(json['main']['temp']),
      lastUpdate: DateFormat.jm()
          .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
    );
  }

  // TODO: remove, do not need this in the actual app
  @override
  String toString() {
    return 'WeatherData{latitude: $latitude, longitude: $longitude, city: $city, country: $country, date: $date, description: $description, temperature: $temperature}';
  }
}
