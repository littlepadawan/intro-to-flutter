import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../models/weather_data.dart';

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
          Wind(
            windSpeed: widget.weatherData?.windSpeed,
            windGust: widget.weatherData?.windGust,
          ),
          const SizedBox(
            height: 30,
          ),
          WeatherIcon(icon: widget.weatherData?.icon),
          Location(
            city: widget.weatherData?.city,
            country: widget.weatherData?.country,
          ),
          const SizedBox(height: 20),
          Date(
            date: widget.weatherData?.date,
          ),
          const SizedBox(height: 8),
          Description(description: widget.weatherData?.description),
          const SizedBox(height: 30),
          Temperature(
            temperature: widget.weatherData?.temperature,
            feelsLike: widget.weatherData?.feelsLike,
          ),
          const SizedBox(height: 50),
          SolarTransitions(
              sunrise: widget.weatherData?.sunrise,
              sunset: widget.weatherData?.sunset)
        ] else ...[
          const Text(
              'Error fetching weather data. Close the app and try again.'),
        ],
      ],
    );
  }
}

class Wind extends StatelessWidget {
  final int? windSpeed;
  final int? windGust;

  const Wind({Key? key, required this.windSpeed, required this.windGust})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 36),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.air,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    '$windSpeed${windGust != null ? " ($windGust m/s)" : " m/s"}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 109, 109, 109),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
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
  final String? date;

  const Date({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$date'),
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
  final int? feelsLike;

  const Temperature(
      {Key? key, required this.temperature, required this.feelsLike})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$temperature°C',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Feels like $feelsLike°C',
              style: const TextStyle(
                color: Color.fromARGB(255, 109, 109, 109),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SolarTransitions extends StatelessWidget {
  final String? sunrise;
  final String? sunset;

  const SolarTransitions(
      {Key? key, required this.sunrise, required this.sunset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          CupertinoIcons.sunrise,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '$sunrise',
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Icon(
          CupertinoIcons.sunset,
          size: 20,
          color: Colors.grey.shade600,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '$sunset',
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 109, 109, 109),
          ),
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
