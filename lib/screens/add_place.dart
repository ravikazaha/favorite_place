import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() {
    return _AddPlaceScreen();
  }
}

class _AddPlaceScreen extends ConsumerState<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedPlaceLocation;

  void _savePlace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty || _selectedImage == null || _selectedPlaceLocation == null) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, _selectedImage!, _selectedPlaceLocation!);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add new Place")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(label: Text("Title")),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
            const SizedBox(height: 10),
            ImageInput(onPickImage: (image) {_selectedImage = image;},),
            const SizedBox(height: 10),
            LocationInput(onSelectLocation: (location) {_selectedPlaceLocation = location;}),
            const SizedBox(height: 16),

            ElevatedButton.icon(onPressed: _savePlace, label: const Text('Add place'), icon: Icon(Icons.add),),
          ],
        ),
      ),
    );
  }
}
