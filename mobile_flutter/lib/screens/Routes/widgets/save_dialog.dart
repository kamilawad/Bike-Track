import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SaveRouteDialog extends StatefulWidget {
  final List<LatLng> polylinePoints;

  const SaveRouteDialog({Key? key, required this.polylinePoints}) : super(key: key);

  @override
  _SaveRouteDialogState createState() => _SaveRouteDialogState();
}

class _SaveRouteDialogState extends State<SaveRouteDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Save Route'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Route Title',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title for the route';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Save the route
              Navigator.pop(context);
              // Navigate back to the routes screen
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}