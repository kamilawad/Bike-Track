import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/Events/events_screen.dart';
import 'package:mobile_flutter/screens/Home/home_screen.dart';
import 'package:mobile_flutter/screens/Map/map_screen.dart';
import 'package:mobile_flutter/screens/Profile/profile_screen.dart';
import 'package:mobile_flutter/screens/Routes/route_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> screens = [HomeScreen(), MapScreen(), RouteScreen(), EventScreen(), ProfileScreen()];
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
            label: "Maps"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.route), 
            label: "Routes"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event), 
            label: "Events"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
            ),
        ],
      ),
    );
  }
}