import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined), 
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route), 
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event), 
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Home",
            ),
        ],
      ),
    );
  }
}