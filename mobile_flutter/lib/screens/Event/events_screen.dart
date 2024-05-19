import 'package:flutter/material.dart';
import 'package:mobile_flutter/screens/Event/single_event_screen.dart';

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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventCollaborationRoom(groupChat: null,)),
                    );
                  },
                  child: EventCard(
                    imagePath: 'assets/onboarding3.png',
                    title: 'Mount Bike',
                    participants: 20,
                    date: DateTime.now(),
                  ),
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