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

      floatingActionButton: InkWell(
        onTap: () {},
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

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('Rides', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0', style: TextStyle(fontSize: 20, color: Color(0xFFF05206),fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  children: [
                    Text('Time', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0h 00m', style: TextStyle(fontSize: 20, color: Color(0xFFF05206), fontWeight: FontWeight.w500)),
                  ],
                ),
                Column(
                  children: [
                    Text('Distance', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('0.00 km', style: TextStyle(fontSize: 20, color: Color(0xFFF05206), fontWeight: FontWeight.w500)),
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

            Card(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: const Image(
                      image: AssetImage('assets/onboarding2.png'),
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Event Name', style: TextStyle(fontSize: 18)),
                        const Text('Event Description'),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Join'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}