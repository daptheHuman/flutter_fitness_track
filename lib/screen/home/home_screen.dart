import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/screen/home/tabs/history_tab.dart';
import 'package:flutter_fitness_track/screen/home/widgets/bottom_nav.dart';
import 'package:flutter_fitness_track/screen/home/tabs/home_tab.dart';
import 'package:flutter_fitness_track/screen/home/tabs/profile_tab.dart';
import 'package:flutter_fitness_track/screen/home/tabs/routines_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;

  final screen = [
    const RoutinesTabs(),
    const HomeTabs(),
    const HistoryTab(),
    const ProfileTab(),
  ];

  void updateIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: screen[_currentIndex]),
        bottomNavigationBar:
            BottomNav(currentScreen: _currentIndex, updateIndex: updateIndex));
  }
}
