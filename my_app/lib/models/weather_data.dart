import 'package:intl/intl.dart';
import 'package:my_app/utilities/capitalize.dart';
import 'package:my_app/utilities/date_format.dart';
import 'package:my_app/utilities/round_double.dart';
import 'location_data.dart';

class WeatherData {
  double? latitude;
  double? longitude;
  String? city;
  String? country;
  String? weekday;
  int? date;
  String? month;
  int? year;
  String? description;
  String? icon;
  double? temperature;
  String? lastUpdate;

  WeatherData(
      {required this.latitude,
      required this.longitude,
      required this.city,
      required this.country,
      required this.weekday,
      required this.date,
      required this.month,
      required this.year,
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
      weekday: getWeekdayAsString(today.weekday),
      date: today.day,
      month: getMonthAsString(today.month),
      year: today.year,
      description: capitalize(json['weather'][0]['description']),
      icon: json['weather'][0]['icon'],
      temperature: roundToOneDecimal(json['main']['temp']),
      lastUpdate: DateFormat.Hm()
          .format(DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000)),
    );
  }

  // TODO: remove, do not need this in the actual app
  @override
  String toString() {
    return 'WeatherData{latitude: $latitude, longitude: $longitude, city: $city, country: $country, date: $weekday, $month $date, $year, description: $description, temperature: $temperature}';
  }
}
