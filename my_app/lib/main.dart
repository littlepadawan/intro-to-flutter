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
          const Padding(
            padding: EdgeInsets.only(top: 60),
            child: Portrait(),
          ),
          Center(
            child: name('Ida Hellqvist'),
          ),
          PersonalCard(),
        ],
      ),
    );
  }
}

class Portrait extends StatelessWidget {
  const Portrait({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage('images/portrait.jpg'),
      radius: 100,
      onBackgroundImageError: (error, stacktrace) {
        debugPrint('Issue loading image: $error, $stacktrace');
      },
    );
  }
}

Widget name(String name) {
  return Text(
    name,
    style: GoogleFonts.zeyada(fontSize: 40),
  );
}

class PersonalCard extends StatelessWidget {
  const PersonalCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Computer Science student',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              cardItem(Icons.mail, Colors.pink, 'Email',
                  'ida.s.hellqvist@gmail.com'),
              cardItem(
                  Icons.phone, Colors.blue, 'Phone number', '070-123 45 67'),
              cardItem(
                  Icons.link, Colors.green, 'Link to web page', 'blablabla'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget cardItem(IconData icon, Color color, String label, String details) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
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
