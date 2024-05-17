import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _dateTime = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  String? _startLocation;
  String? _endLocation;
  String _eventType = 'public';

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text;
      final description = _descriptionController.text;
      final startTime = DateTime(_dateTime.year, _dateTime.month, _dateTime.day, _time.hour, _time.minute);
      final eventType = _eventType;

      final createEventDto = {
        'title': title,
        'description': description,
        'startTime': startTime.toIso8601String(),
        'startLocationType': 'Point',
        'startLocationCoordinates': _startLocation?.split(','),
        'endLocationType': 'Point',
        'endLocationCoordinates': _endLocation?.split(','),
        'eventType': eventType,
      };

      try {
        final response = await http.post(
          Uri.parse('https://your-backend.com/events'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(createEventDto),
        );

        if (response.statusCode == 201) {
          // Event created successfully
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Event created successfully')),
          );
        } else {
          // Error creating event
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating event: ${response.statusCode}')),
          );
        }
      } catch (e) {
        // Error handling
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('An error occurred')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Create Event',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Handle route selection
                    },
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF05206)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.map_rounded, color: Color(0xFFF05206)),
                            SizedBox(width: 10),
                            Text(
                              "Add Route",
                              style: TextStyle(
                                color: Color(0xFFF05206),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Handle poster selection
                    },
                    child: Container(
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFF05206)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.photo, color: Color(0xFFF05206)),
                            SizedBox(width: 10),
                            Text(
                              "Add Poster",
                              style: TextStyle(
                                color: Color(0xFFF05206),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100, 4, 22),
                        initialDate: _dateTime,
                      );
                      if (date != null) {
                        setState(() {
                          _dateTime = date;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.black12),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      elevation: MaterialStateProperty.all(0),
                    ),
                    child: SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.date_range_rounded, color: Colors.black54),
                                const SizedBox(width: 10),
                                Text( DateFormat('MMMM d').format(_dateTime),
                                  style: const TextStyle(color: Colors.black54)
                                ),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(_dateTime),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _time = pickedTime;
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.black12),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      elevation: MaterialStateProperty.all(0),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) return Colors.black12;
                          return null;
                        },
                      ),
                    ),
                    child: SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.access_time, color: Colors.black54),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat('jm').format(DateTime(_dateTime.year, _dateTime.month, _dateTime.day, _time.hour, _time.minute)),
                                  style: const TextStyle(color: Colors.black54)
                                ),
                              ],
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _eventType,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _eventType = value;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Event Type',
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'public',
                        child: Text('Public'),
                      ),
                      DropdownMenuItem(
                        value: 'private',
                        child: Text('Private'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle participant selection
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(color: Colors.black12),
                        ),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      elevation: MaterialStateProperty.all(0),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.pressed)) return Colors.black12;
                          return null;
                        },
                      ),
                    ),
                    child: const SizedBox(
                      height: 50.0,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.ios_share_rounded, color: Colors.black54),
                                SizedBox(width: 10),
                                Text(
                                  'Add participants',
                                  style: TextStyle(color: Colors.black54)
                                ),
                              ],
                            ),
                            Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFF05206)),
                      elevation: 0,
                    ),
                    onPressed: _submitForm,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: Color(0xFFF05206),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}