import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // The root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Me Card',
      theme: ThemeData(
        // The theme of the application.
        primarySwatch: Colors.lightBlue,
        // useMaterial3: true,
      ),
      home: const MeCard(),
    );
  }
}

class MeCard extends StatelessWidget {
  const MeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Card'),
      ),
      body: ListView(
        // padding: ,
        children: [
          Image.asset('images/portrait.jpg'),
          Text('Ida Hellqvist'),
          PersonalCard(),
        ],
      ),
    );
  }
}

class PersonalCard extends StatelessWidget {
  const PersonalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Role',
            ),
            cardRow('images/icons8-email-40.png', 'ida.s.hellqvist@gmail.com'),
            cardRow('images/icons8-phone-40.png', '0708-53 24 35'),
            cardRow('images/icons8-github-48.png', 'blablabla'),
          ],
        ),
      ),
    );
  }
}

Widget cardRow(String iconPath, String details) {
  return Row(
    mainAxisSize: MainAxisSize.min, // Height of rows
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Image.asset(iconPath),
      ),
      Expanded(
        child: Text(details),
      )
    ],
  );
}
