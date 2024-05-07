import 'package:flutter/material.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.chat, color: Color.fromARGB(151, 0, 0, 0))),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Color.fromARGB(151, 0, 0, 0))),
        ],
      ),
    );
  }
}