import 'package:flutter/material.dart';

import 'widgets/event_card.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(text: "Events"),
              Tab(text: "Public Events"),
            ],
          ),
          title: const Text('Event Screen'),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: [
                EventCard(
                  imagePath: 'assets/onboarding3.png',
                  title: 'Mount Bike',
                  participants: 20,
                  date: DateTime.now(),
                ),
              ],
            ),
            const Center(child: Text("Screen 2")),
          ],
        ),
      ),
    );
  }
}