import 'package:flutter/material.dart';

import 'add_workout_screen.dart';
import 'workouts_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void handleBottomNavigationBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    const WorkoutsScreen(),
    const AddWorkoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: handleBottomNavigationBarTap,
          selectedItemColor: Theme.of(context).primaryColor,
          items: const [
            BottomNavigationBarItem(
              label: 'Workouts',
              icon: Icon(Icons.list_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Add',
              icon: Icon(Icons.add_box_rounded),
            )
          ],
        ),
        body: _screens[_currentIndex],
      ),
    );
  }
}
