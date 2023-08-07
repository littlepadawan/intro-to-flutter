import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/widgets/current_weather_display.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:my_app/providers/geolocation_coordinates.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/providers/fetch_weather_data.dart';
import 'package:my_app/widgets/error_dialog.dart';

import '../models/weather_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? currentWeather;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getLocationPermission();
  }

  Future<void> _getLocationPermission() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      await _getLocationCoordinates();
      return;
    } else {
      ErrorDialog.showErrorDialog(context, 'Location Permission Denied',
          'Please provide location permission to use the app. To do this, update location permission in app settings and restart the app.');
    }
  }

  Future<void> _getLocationCoordinates() async {
    try {
      Position position = await getCurrentCoordinates();
      await _fetchData(position.latitude, position.longitude);
    } on TimeoutException catch (_) {
      ErrorDialog.showErrorDialog(context, 'Location Error',
          'Location request timeout. Close the app and try again.');
    } on LocationServiceDisabledException catch (_) {
      ErrorDialog.showErrorDialog(context, 'Location Error',
          'Location service is disabled. Update location permission in settings and try again.');
    } catch (_) {
      ErrorDialog.showErrorDialog(
          context, 'Location Error', 'Error getting location.');
    }
  }

  Future<void> _fetchData(double latitude, double longitude) async {
    try {
      WeatherData data = await fetchWeatherData(latitude, longitude);
      setState(() {
        currentWeather = data;
      });
    } catch (e) {
      String error = e.toString(); // TODO: Remove before handin
      ErrorDialog.showErrorDialog(context, 'Data Error',
          '$error. Error fetching weather data. Click refresh to try again.');
    }
  }

  @override
  // TODO: Add button to trigger new datafetch
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current weather'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: CurrentWeatherDisplay(
                weatherData: currentWeather,
                refreshCallback: _getLocationCoordinates,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Last updated: ${currentWeather?.lastUpdate}'),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _getLocationCoordinates,
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
