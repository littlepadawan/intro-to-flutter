import 'package:flutter/material.dart';
import 'package:my_app/widgets/navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('This is the home page'),
      ),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}
