import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/screens/forecast.dart';

GoRoute routeForecast() {
  return GoRoute(
    path: '/forecast',
    pageBuilder: (context, state) {
      return const MaterialPage(
        child: ForecastPage(),
      );
    },
  );
}
