import 'package:flutter/material.dart';
import 'package:my_app/models/weather_data.dart';

import '../utilities/capitalize.dart';

class CurrentWeatherDisplay extends StatefulWidget {
  final WeatherData? weatherData;
  final VoidCallback refreshCallback;

  const CurrentWeatherDisplay({
    Key? key,
    required this.weatherData,
    required this.refreshCallback,
  }) : super(key: key);

  @override
  State<CurrentWeatherDisplay> createState() => _CurrentWeatherDisplayState();
}

class _CurrentWeatherDisplayState extends State<CurrentWeatherDisplay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 40),
        if (widget.weatherData != null) ...[
          Location(
            city: widget.weatherData?.city,
            country: widget.weatherData?.country,
          ),
          const SizedBox(height: 20),
          Date(
            weekday: widget.weatherData?.weekday,
            date: widget.weatherData?.date,
            month: widget.weatherData?.month,
            year: widget.weatherData?.year,
          ),
          const SizedBox(height: 8),
          Description(description: widget.weatherData?.description),
          const SizedBox(height: 30),
          Temperature(temperature: widget.weatherData?.temperature),
        ] else ...[
          const Text(
              "Something went wrong fetching the weather. Restart the app to try again."),
        ],
      ],
    );
  }
}

class Location extends StatelessWidget {
  final String? city;
  final String? country;

  const Location({Key? key, this.city, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$city, $country',
          style: const TextStyle(fontSize: 22),
        ),
      ],
    );
  }
}

class Date extends StatelessWidget {
  final String? weekday;
  final int? date;
  final String? month;
  final int? year;

  const Date({Key? key, this.weekday, this.date, this.month, this.year})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$weekday, $month $date, $year'),
      ],
    );
  }
}

class Description extends StatelessWidget {
  final String? description;

  const Description({Key? key, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$description'),
      ],
    );
  }
}

class Temperature extends StatelessWidget {
  final double? temperature;

  const Temperature({Key? key, this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$temperature °C',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
