import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
          '$error. Error fetching weather data. Close the app and try again.');
    }
  }

  @override
  // TODO: Add button to trigger new datafetch
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              currentWeather != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        currentWeather.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  : Container(),
            ]),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
