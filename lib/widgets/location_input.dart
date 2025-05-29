import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final void Function(PlaceLocation placeLocation) onSelectLocation;

  const LocationInput({required this.onSelectLocation, super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInput();
  }
}

class _LocationInput extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if (lat == null || lng == null) {
      return;
    }

    setState(() {
      _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
      _isGettingLocation = false;
      widget.onSelectLocation(_pickedLocation!);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent =
        _pickedLocation == null
            ? Text(
              "No location chosen",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            )
            : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Latitude", style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 4,),
                Text(_pickedLocation!.latitude.toString(), style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
                SizedBox(height: 12,),
                Text("Longitude", style: Theme.of(context).textTheme.titleSmall,),
                SizedBox(height: 4,),
                Text(_pickedLocation!.longitude.toString(), style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),
              ],
            );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          height: 170,
          width: double.infinity,
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.location_on),
              label: const Text('Get current location'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: const Text('Select on map'),
            ),
          ],
        ),
      ],
    );
  }
}
