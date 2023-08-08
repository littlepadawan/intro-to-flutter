import 'package:flutter/material.dart';
import 'package:my_app/models/weather_data.dart';

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
        if (widget.weatherData != null) ...[
          WeatherIcon(icon: widget.weatherData?.icon),
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
              'Error fetching weather data. Close the app and try again.'),
        ],
      ],
    );
  }
}

class WeatherIcon extends StatelessWidget {
  final String? icon;

  const WeatherIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/weather_icons/$icon.png',
          width: 180,
          height: 180,
        ),
      ],
    );
  }
}

class Location extends StatelessWidget {
  final String? city;
  final String? country;

  const Location({Key? key, required this.city, required this.country})
      : super(key: key);

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

  const Date(
      {Key? key,
      required this.weekday,
      required this.date,
      required this.month,
      required this.year})
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

  const Description({Key? key, required this.description}) : super(key: key);

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

  const Temperature({Key? key, required this.temperature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$temperature°C',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Error fetching weather data. Refresh or close the app to try again.',
        ),
      ],
    );
  }
}
