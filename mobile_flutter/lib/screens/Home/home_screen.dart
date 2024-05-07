import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat, color: Color.fromARGB(151, 0, 0, 0))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Color.fromARGB(151, 0, 0, 0))),
        ],
      ),

      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Analysis', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Rides', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0', style: TextStyle(fontSize: 20, color: Color(0xFFF05206))),
                  ],
                ),
                Column(
                  children: [
                    Text('Time', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0h 00m', style: TextStyle(fontSize: 20, color: Color(0xFFF05206))),
                  ],
                ),
                Column(
                  children: [
                    Text('Distance', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0.00 km', style: TextStyle(fontSize: 20, color: Color(0xFFF05206))),
                  ],
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}