import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  DateTime dateTime = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
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
                    onTap: () {},
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
                      final date = await pickDate();
                      if (date == null) return;
                      setState(() {
                        dateTime = date;
                      });
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
                                Text(
                                  DateFormat('MMMM d').format(dateTime),
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
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if(pickedTime == null) return;

                      setState(() {
                        time = pickedTime;
                      });
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
                                const Icon(Icons.access_time, color: Colors.black54),
                                const SizedBox(width: 10),
                                Text(
                                  DateFormat('jm').format(DateTime(dateTime.year, dateTime.month, dateTime.day, time.hour, time.minute)),
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

                  const SizedBox(height: 60),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Color(0xFFF05206)),
                      elevation: 0,
                    ),
                    
                    onPressed: () {},
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

  Future<DateTime?> pickDate() => showDatePicker(
    context: context,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100, 4, 22),
    initialDate: DateTime.now(),
  );
}