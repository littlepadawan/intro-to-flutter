import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hello from Flutter'),
          leading: const Icon(Icons.flutter_dash),
        ),
        body: const Center(
          child: Text(
            'Hello Flutter!',
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
  }
}
