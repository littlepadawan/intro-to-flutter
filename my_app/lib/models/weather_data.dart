import 'package:my_app/utilities/date_format.dart';

class WeatherData {
  String? location;
  String? weekday;
  int? date;
  String? month;
  int? year;
  String? description;
  double? temperature;

  WeatherData({
    required this.location,
    required this.weekday,
    required this.date,
    required this.month,
    required this.year,
    required this.description,
    required this.temperature,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    //TODO get location by geocoding AOI and not from this json
    //TODO get current date from actual API?
    //TODO get date as weekday, month, date, year
    // TODO round temperature to integer
    //TODO get time of data fetch
    DateTime today = DateTime.now();
    return WeatherData(
      location: json['name'],
      weekday: getWeekdayAsString(today.weekday),
      date: today.day,
      month: getMonthAsString(today.month),
      year: today.year,
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
    );
  }

  // TODO: remove, do not need this in the actual app
  @override
  String toString() {
    return 'WeatherData{location: $location, date: $weekday, $month $date, $year, description: $description, temperature: $temperature}';
  }
}
