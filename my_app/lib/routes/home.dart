import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/home.dart';

GoRoute routeHome() {
  return GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return const MaterialPage(
        child: HomePage(),
      );
    },
  );
}
