import 'package:my_app/models/forecast_data.dart';

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

    currentDayEntries.add(
      ForecastEntry(
        time: entryDate,
        icon: forecastEntry['weather'][0]['icon'],
        temperature: (forecastEntry['main']['temp']).round(),
        pop: (forecastEntry['pop'] * 100).round(),
        windSpeed: (forecastEntry['wind']['speed']).round(),
        windGust: forecastEntry['wind']['gust'] != null
            ? forecastEntry['wind']['deg'] as int
            : 0,
        windDeg: forecastEntry['wind']['deg'],
      ),
    );
  }

  return forecastDays;
}
