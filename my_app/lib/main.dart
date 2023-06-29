import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage('images/portrait.jpg'),
            radius: 100,
            onBackgroundImageError: (error, stacktrace) {
              debugPrint('Issue loading image: $error, $stacktrace');
            },
          ),
          Center(
            child: Text(
              'Ida Hellqvist',
              style: GoogleFonts.zeyada(fontSize: 40),
            ),
          ),
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
          child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Role',
            ),
            cardRow(
                Icons.mail, Colors.pink, 'Email', 'ida.s.hellqvist@gmail.com'),
            cardRow(Icons.phone, Colors.blue, 'Phone number', '070-123 45 67'),
            cardRow(Icons.link, Colors.green, 'Link to web page', 'blablabla'),
          ],
        ),
      )),
    );
  }
}

Widget cardRow(IconData icon, Color color, String label, String details) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    horizontalTitleGap: -2,
    visualDensity: const VisualDensity(vertical: -4),
    leading: Icon(
      icon,
      color: color,
      semanticLabel: label,
    ),
    title: Text(details),
  );
}
