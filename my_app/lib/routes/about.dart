import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/about.dart';

GoRoute routeAbout() {
  return GoRoute(
    path: '/about',
    pageBuilder: (context, state) {
      return const MaterialPage(
        child: AboutPage(),
      );
    },
  );
}
