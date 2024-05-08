import 'package:flutter/material.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track your ride', style: TextStyle(color: Colors.black54)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Transform.scale(
            scale: 0.9,
            child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: const Center(
        child: Text('Map'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFFF05206),
              elevation: 0,
              highlightElevation: 0,
              child: const Icon(Icons.stop, size: 36,)
            ),
          ),
          Container(
            color: Colors.white,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Distance'),
                      Text('0.0'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Time'),
                      Text('0:00:00'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Avg Speed'),
                      Text('0.0'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}