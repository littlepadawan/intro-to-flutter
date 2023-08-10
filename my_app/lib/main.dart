import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/home.dart';
import '../routes/forecast.dart';
import '../routes/about.dart';

void main() {
  final goRouter = GoRouter(
    routes: [
      routeHome(),
      routeForecast(),
      routeAbout(),
    ],
  );
  runApp(MyApp(goRouter: goRouter));
}

class MyApp extends StatelessWidget {
  final GoRouter goRouter;
  const MyApp({Key? key, required this.goRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}
