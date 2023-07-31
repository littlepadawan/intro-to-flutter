import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PermissionDeniedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Permission Denied'),
      content: const Text(
          'Please provide location permission to use the app. To do this, update location permission in app settings and restart the app.'),
      actions: <Widget>[
        TextButton(
          child: const Text('Close the app'),
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
      ],
    );
  }
}
