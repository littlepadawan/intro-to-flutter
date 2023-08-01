import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(
      {super.key, required this.title, required this.errorMessage});

  final String title;
  final String errorMessage;

  static Future<void> showErrorDialog(
      BuildContext context, String title, String errorMessage) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ErrorDialog(
          title: title,
          errorMessage: errorMessage,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
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
