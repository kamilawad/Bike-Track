import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: "Events"),
              Tab(text: "Public Events"),
            ],
          ),
          title: Text('Event Screen'),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("Screen 1")),
            Center(child: Text("Screen 2")),
          ],
        ),
      ),
    );
  }
}