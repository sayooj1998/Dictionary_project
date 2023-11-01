import 'package:flutter/material.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.zoom_in),
          label: 'Start With',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.view_comfy),
          label: 'Contain',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.zoom_out),
          label: 'End With',
        ),
      ],
    );
  }
}
