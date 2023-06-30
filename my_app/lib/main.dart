import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Text Copier'),
      ),
      body: const Copier(),
    ));
  }
}

class Copier extends StatefulWidget {
  const Copier({super.key});

  @override
  State<Copier> createState() => _CopierState();
}

class _CopierState extends State<Copier> {
  String _textFieldValue = '';
  String _copiedText = '';

  void _copyText() {
    setState(() {
      _copiedText = _textFieldValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                _textFieldValue = value;
              },
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _copyText,
              child: const Text('Press to copy'),
            ),
            const SizedBox(height: 20),
            const Text(
              "Copied Text: ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(_copiedText,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
