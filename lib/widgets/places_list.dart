import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/places_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList({required this.places, super.key});

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No places added yet",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: places.length,
      itemBuilder:
          (ctx, index) => ListTile(
            leading: CircleAvatar(radius: 26, backgroundImage: FileImage(places[index].image),),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PlaceDetailScreen(place: places[index]),
                ),
              );
            },
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            subtitle: Text("${places[index].placeLocation!.latitude}, ${places[index].placeLocation!.longitude}"),
          ),
    );
  }
}
