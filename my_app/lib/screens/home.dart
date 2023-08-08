import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:my_app/widgets/current_weather_display.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/widgets/error_dialog.dart';

import 'package:my_app/providers/geolocation_coordinates.dart';
import 'package:my_app/providers/fetch_weather_data.dart';

import '../models/weather_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherData? currentWeather;
  bool isLoading = true;

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
      setState(() {
        isLoading = true;
      });

      Position position = await getCurrentCoordinates();
      await _fetchData(position.latitude, position.longitude);

      setState(() {
        isLoading = false;
      });
    } on TimeoutException catch (_) {
      ErrorDialog.showErrorDialog(context, 'Location Error',
          'Location request timeout. Close the app and try again.');
    } on LocationServiceDisabledException catch (_) {
      ErrorDialog.showErrorDialog(context, 'Location Error',
          'Location service is disabled. Update location permission in settings and try again.');
    } catch (_) {
      ErrorDialog.showErrorDialog(context, 'Location Error',
          'Error getting location. Close the app and try again.');
    }
  }

  Future<void> _fetchData(double latitude, double longitude) async {
    try {
      WeatherData data = await fetchWeatherData(latitude, longitude);
      setState(() {
        currentWeather = data;
        isLoading = false;
      });
    } catch (e) {
      ErrorDialog.showErrorDialog(context, 'Data Error',
          'Error fetching weather data. Close the app and try again.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current weather'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RefreshSection(refreshCallback: _getLocationCoordinates),
            ),
          ),
          const SizedBox(height: 100),
          if (isLoading) ...[
            const CircularProgressIndicator(),
          ] else ...[
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
                child: LastUpdatedSection(
                  lastUpdate: currentWeather?.lastUpdate,
                ),
              ),
            )
          ],
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class RefreshSection extends StatelessWidget {
  final VoidCallback refreshCallback;

  const RefreshSection({Key? key, required this.refreshCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Spacer(),
        IconButton(
          onPressed: refreshCallback,
          icon: const Icon(Icons.refresh, color: Colors.grey, size: 20),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class LastUpdatedSection extends StatelessWidget {
  final String? lastUpdate;

  const LastUpdatedSection({Key? key, required this.lastUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Last updated: $lastUpdate',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(width: 18),
      ],
    );
  }
}
