import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  final int currentScreen;
  final Function(int) updateIndex;
  const BottomNav(
      {super.key, required this.currentScreen, required this.updateIndex});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        unselectedItemColor: Colors.indigo.shade900,
        fixedColor: Colors.indigo.shade500,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: widget.currentScreen,
        onTap: (value) => {
              setState(() {
                widget.updateIndex(value);
              }),
            },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), label: "Routines"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_outlined), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity_outlined), label: "Profile"),
        ]);
  }
}
