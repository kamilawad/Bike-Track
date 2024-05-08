import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track your ride', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),

      body: const Center(
        child: Text('Map'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFFF05206),
          elevation: 0,
          highlightElevation: 0,
          child: const Text(
            'Start',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
    );
  }
}