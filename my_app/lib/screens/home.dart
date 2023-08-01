import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_app/providers/current_location.dart';
import 'package:my_app/widgets/location_error_dialog.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/providers/fetch_weather_data.dart';
import 'package:geolocator/geolocator.dart';
import 'package:my_app/widgets/permission_denied_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

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
    await _getCurrentLocation();
    if (currentLatitude != null && currentLongitude != null) {
      await _fetchData();
    }
  }

  Future<void> _getCurrentLocation() async {
    PermissionStatus permissionStatus = await Permission.location.request();

    if (permissionStatus.isGranted) {
      try {
        Position position = await getCurrentLocation();
        setState(() {
          currentLatitude = position.latitude.toString();
          currentLongitude = position.longitude.toString();
        });
      } on TimeoutException catch (_) {
        _showLocationErrorDialog(
            'Location request timeout. Close the app and try again.');
      } on LocationServiceDisabledException catch (_) {
        _showLocationErrorDialog(
            'Location service is disabled. Update this in settings and try again.');
      } catch (_) {
        _showLocationErrorDialog('Error getting location.');
      }
    } else {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> _showLocationErrorDialog(String errorMessage) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LocationErrorDialog(errorMessage: errorMessage);
      },
    );
  }

  Future<void> _showPermissionDeniedDialog() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PermissionDeniedDialog();
      },
    );
  }

  Future<void> _fetchData() async {
    try {
      String data = await fetchWeatherData(currentLatitude!, currentLongitude!);
      setState(() {
        fetchedData = data;
      });
    } catch (error) {
      setState(() {
        fetchedData = 'Error fetching data';
      });
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
