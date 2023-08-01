import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocationErrorDialog extends StatelessWidget {
  final String errorMessage;

  const LocationErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Location Error'),
      content: Text(errorMessage),
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
