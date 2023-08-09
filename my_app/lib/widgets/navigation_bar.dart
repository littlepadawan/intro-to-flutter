import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0; // To track which screen is active/clicked

  // const CustomBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sunny),
          label: 'Current',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: 'Forecast',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _changeIndex,
    );
  }

  void _changeIndex(int index) {
    switch (index) {
      case 0:
        {
          GoRouter.of(context).go('/');
        }
        break;
      case 1:
        {
          GoRouter.of(context).go('/forecast');
        }
        break;
      case 2:
        {
          GoRouter.of(context).go('/about');
          break;
        }
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}
