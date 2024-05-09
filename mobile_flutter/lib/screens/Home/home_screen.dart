import 'package:flutter/material.dart';
import 'package:mobile_flutter/data/static/event_data.dart';
import 'package:mobile_flutter/screens/Home/widgets/event_widget.dart';

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
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/chat');
            }, 
            icon: const Icon(Icons.chat, color: Color.fromARGB(151, 0, 0, 0))
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications, color: Color.fromARGB(151, 0, 0, 0))),
        ],
      ),

      floatingActionButton: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/event');
        },
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            color: Color(0xFFF05206),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Rides', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('0', style: TextStyle(fontSize: 18, color: Color(0xFFF05206),fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  children: [
                    Text('Time', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('0h 00m', style: TextStyle(fontSize: 18, color: Color(0xFFF05206), fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  children: [
                    Text('Distance', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 10),
                    Text('0.00 km', style: TextStyle(fontSize: 18, color: Color(0xFFF05206), fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
        
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text('Suggested Events', style: TextStyle(fontSize: 18))
                ),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {}, 
                    child: const Text("See More")
                  ),
                ),
              ],
            ),

            EventWidget(event: events[0]),
            EventWidget(event: events[1]),
          ],
        ),
      ),
    );
  }
}