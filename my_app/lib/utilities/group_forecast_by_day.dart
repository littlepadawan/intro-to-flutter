import 'package:my_app/models/forecast_data.dart';
import 'package:my_app/utilities/capitalize.dart';

List<ForecastDay> groupForecastByDay(Map<String, dynamic> json) {
  final List<dynamic> forecastList = json['list']; // Data from API
  final List<ForecastDay> forecastDays = [];

  DateTime currentDate = DateTime.now().subtract(const Duration(
      days:
          1)); // "Yesterday". Variable used to compare dates of forecast entries
  List<ForecastEntry> currentDayEntries = [];

  for (var forecastEntry in forecastList) {
    DateTime entryDate = DateTime.fromMillisecondsSinceEpoch(
        forecastEntry['dt'] * 1000); // Date of current entry

    if (entryDate.day != currentDate.day) {
      // If true, it means we're entering a new day
      ForecastDay forecastDay = ForecastDay(
        date: currentDate,
        entries: currentDayEntries,
      ); // Add all entries for currentDate to new forecastDay
      forecastDays.add(forecastDay);

      currentDayEntries = [];
      currentDate = entryDate;
    }

    final temperature = (forecastEntry['main']['temp']).round();
    final pop = (forecastEntry['pop'] * 100).round();
    final icon = forecastEntry['weather'][0]['icon'];
    final windSpeed = (forecastEntry['wind']['speed']).round();
    final windGust = (forecastEntry['wind']['gust']).round();
    final windDeg = (forecastEntry['wind']['deg']).round();

    currentDayEntries.add(
      ForecastEntry(
        time: entryDate,
        icon: icon,
        temperature: temperature,
        pop: pop,
        windSpeed: windSpeed,
        windGust: windGust,
        windDeg: windDeg,
      ),
    );
  }

  return forecastDays;
}
