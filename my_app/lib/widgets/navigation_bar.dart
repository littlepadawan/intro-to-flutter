import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNavigationBar extends StatefulWidget {
  final int startIndex;
  const CustomNavigationBar({Key? key, required this.startIndex})
      : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  late int _selectedIndex; // To track which screen is active/clicked

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.startIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _navigateToScreen,
      fixedColor: Theme.of(context).primaryColor,
      items: <BottomNavigationBarItem>[
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
    );
  }

  void _navigateToScreen(int index) {
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
