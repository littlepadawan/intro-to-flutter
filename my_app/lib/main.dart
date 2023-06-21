import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layouts in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const LayoutPage(),
    );
  }
}

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Layout'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Star Wars Characters',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                characterRow('Grogu', 'images/icons8-baby-yoda-48.png'),
                const SizedBox(height: 10),
                characterRow('C-3PO', 'images/icons8-c-3po-48.png'),
                const SizedBox(height: 10),
                characterRow('R2-D2', 'images/icons8-r2-d2-48.png'),
                const SizedBox(height: 10),
                characterRow(
                    'Stormtrooper', 'images/icons8-stormtrooper-48.png'),
              ],
            ),
          ),
        ));
  }
}

Widget characterRow(String name, String imagePath) {
  return Row(
    mainAxisSize: MainAxisSize.min, // Fix height of rows
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(
        child: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
      ),
      Expanded(
        child: Image.asset(imagePath),
      ),
    ],
  );
}
