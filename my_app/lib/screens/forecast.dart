import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:my_app/providers/geolocation_coordinates.dart';
import 'package:my_app/providers/fetch_forecast_data.dart';
import 'package:my_app/widgets/error_dialog.dart';

import 'package:my_app/models/forecast_data.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:my_app/widgets/forecast_display.dart';

class ForecastPage extends StatefulWidget {
  const ForecastPage({super.key});

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}

class _ForecastPageState extends State<ForecastPage> {
  ForecastData? forecastData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getLocationCoordinates();
  }

  Future<void> _getLocationCoordinates() async {
    try {
      setState(() {
        isLoading = true;
      });
      Position position = await getCurrentCoordinates();
      await _fetchForecastData(position.latitude, position.longitude);
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

  Future<void> _fetchForecastData(double latitude, double longitude) async {
    try {
      ForecastData data = await fetchForecastData(latitude, longitude);
      setState(() {
        forecastData = data;
        isLoading = false;
      });
    } catch (e) {
      ErrorDialog.showErrorDialog(context, 'Data Error',
          '${e.toString()}.  fetching forecast data. Close the app and try again.');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: forecastData != null
            ? Text('Forecast ${forecastData?.city}, ${forecastData?.country}')
            : const Text('Forecast'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : forecastData == null
              ? const Center(
                  child: Text('No forecast data available'),
                )
              : ForecastDisplay(
                  forecastDays: forecastData!.forecastDays!,
                ),
      bottomNavigationBar: const CustomNavigationBar(
        startIndex: 1,
      ),
    );
  }
}
