import 'package:flutter/material.dart';
import 'package:my_app/widgets/navigation_bar.dart';
import 'package:flutter/services.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.stretch, // uncomment to left align text
          children: [
            SizedBox(height: 30),
            header(),
            SizedBox(height: 20),
            appDescription(),
            SizedBox(height: 20),
            author(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

Widget header() {
  return const Text(
    'The Weather App',
    style: TextStyle(
      fontSize: 22,
    ),
  );
}

Widget appDescription() {
  return const Text(
    'This is an app that is developed for the course 1DV535 at Linnaeus University the summer of 2023, using Flutter and the OpenWeatherMap API.',
    textAlign: TextAlign.center,
  );
}

Widget author() {
  return const Text(
    'Developed by Ida Hellqvist.',
    textAlign: TextAlign.left,
  );
}
