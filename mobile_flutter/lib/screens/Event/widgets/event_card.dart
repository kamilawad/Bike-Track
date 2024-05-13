import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final int participants;
  final DateTime date;

  EventCard({
    required this.imagePath,
    required this.title,
    required this.participants,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFF05206)),
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.directions_bike),
                    Text(' $participants participants'),
                  ],
                ),
                Text('Date: ${DateFormat.yMMMd().format(date)}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}