import 'package:flutter/foundation.dart';

class Tour {
  factory Tour.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    final String islandId = data['islandId'];
    final String name = data['name'];
    final String description = data['description'];
    final String imageUrl = data['imageUrl'];
    final int people = data['people'];
    final int duration = data['duration'];
    final features = List<String>.from(data['features'].map((x) => x));
    final sightseeing = List<String>.from(data['sightseeing'].map((x) => x));
    final double rating = data['rating'];
    return Tour(
      id: documentId,
      islandId: islandId,
      name: name,
      description: description,
      imageUrl: imageUrl,
      people: people,
      duration: duration,
      features: features,
      sightseeing: sightseeing,
      rating: rating,
    );
  }
  Tour({
    @required this.id,
    @required this.islandId,
    @required this.name,
    @required this.description,
    @required this.imageUrl,
    @required this.people,
    @required this.duration,
    @required this.features,
    @required this.sightseeing,
    @required this.rating,
  });

  final String id;
  final String islandId;
  final String name;
  final String description;
  final String imageUrl;
  final int people;
  final int duration;
  final List<String> features;
  final List<String> sightseeing;
  final double rating;

  Map<String, dynamic> toMap() {
    return {
      'islandId': islandId,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'people': people,
      'duration': duration,
      'features': List<dynamic>.from(features.map((x) => x)),
      'sightseeing': List<dynamic>.from(sightseeing.map((x) => x)),
      'rating': rating,
    };
  }
}
