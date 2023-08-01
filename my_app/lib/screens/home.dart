import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:my_app/providers/current_location.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/providers/fetch_weather_data.dart';
import 'package:my_app/widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fetchedData;
  String? currentLatitude;
  String? currentLongitude;

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
    } else {
      ErrorDialog.showErrorDialog(context, 'Location Permission Denied',
          'Please provide location permission to use the app. To do this, update location permission in app settings and restart the app.');
    }
  }

  Future<void> _getLocationCoordinates() async {
    try {
      Position position = await getCurrentLocation();
      setState(
        () {
          currentLatitude = position.latitude.toString();
          currentLongitude = position.longitude.toString();
        },
      );
      await _fetchData();
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

  Future<void> _fetchData() async {
    try {
      String data = await fetchWeatherData(currentLatitude!, currentLongitude!);
      setState(() {
        fetchedData = data;
      });
    } catch (_) {
      ErrorDialog.showErrorDialog(context, 'Data Error',
          'Error fetching weather data. Close the app and try again.');
    }
  }

  @override
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
              fetchedData != null
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        fetchedData!,
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
