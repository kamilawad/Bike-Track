import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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