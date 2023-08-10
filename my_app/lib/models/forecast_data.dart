import 'package:my_app/utilities/group_forecast_by_day.dart';
import 'location_data.dart';

class ForecastData {
  double? latitude;
  double? longitude;
  String? city;
  String? country;
  List<ForecastDay>? forecastDays;

  ForecastData({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.country,
    required this.forecastDays,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json, double latitude,
      double longitude, LocationData locationData) {
    final List<ForecastDay> forecastDays = groupForecastByDay(json);

    return ForecastData(
      latitude: latitude,
      longitude: longitude,
      city: json['city']
          ['name'], // TODO: error handling since func is depracated?
      country: locationData.country,
      forecastDays: forecastDays,
    );
  }

  // TODO: remove, do not need this in the actual app
  @override
  String toString() {
    return 'ForecastData{latitude: $latitude, longitude: $longitude, city: $city, country: $country, forecast: $forecastDays}';
  }
}

class ForecastDay {
  final DateTime date;
  final List<ForecastEntry> entries;

  ForecastDay({
    required this.date,
    required this.entries,
  });
}

class ForecastEntry {
  final DateTime time;
  final String? icon;
  final int temperature;
  final int pop;
  final int windSpeed;
  final int windGust;
  final int windDeg;

  ForecastEntry({
    required this.time,
    required this.icon,
    required this.temperature,
    required this.pop,
    required this.windSpeed,
    required this.windGust,
    required this.windDeg,
  });
}
