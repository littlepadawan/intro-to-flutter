import 'package:flutter/material.dart';
import '../widgets/navigation_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            header(),
            const SizedBox(height: 20),
            appDescription(),
            const SizedBox(height: 20),
            author(),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(
        startIndex: 2,
      ),
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
