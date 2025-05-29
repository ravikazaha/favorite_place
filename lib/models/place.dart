import 'dart:io';

import 'package:uuid/uuid.dart';

class PlaceLocation {
  double? latitude;
  double? longitude;

  PlaceLocation({this.latitude, this.longitude});
}

class Place {
  final String id;
  final String title;
  final File image;
  PlaceLocation? placeLocation;

  Place({required this.title, required this.image, this.placeLocation}) : id = Uuid().v4();
}