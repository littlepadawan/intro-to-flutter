import 'package:flutter/material.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? fetchedData;

  Future<void> _fetchJsonData() async {
    const url =
        'https://api.openweathermap.org/data/2.5/weather?q=Paris&appid=5430333b2b984d9cf3d533524975465e';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        fetchedData = json.decode(response.body).toString();
      });
    } else {
      throw Exception('Failed to load JSON data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _fetchJsonData,
              child: const Text('Fetch Data'),
            ),
            const SizedBox(height: 30),
            fetchedData != null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      fetchedData!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
