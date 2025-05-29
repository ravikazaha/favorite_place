import 'package:favorite_places/providers/user_places_provider.dart';
import 'package:favorite_places/screens/add_place.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  void _toAddPlaceScreen(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const AddPlaceScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: () {
              _toAddPlaceScreen(context);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(padding: EdgeInsets.all(8), child: PlacesList(places: userPlaces),),
    );
  }
}
