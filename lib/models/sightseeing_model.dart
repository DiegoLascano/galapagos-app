import 'package:flutter/foundation.dart';

class Sightseeing {
  factory Sightseeing.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    final String name = data['name'];
    final String imageUrl = data['imageUrl'];
    return Sightseeing(
      id: documentId,
      name: name,
      imageUrl: imageUrl,
    );
  }
  Sightseeing({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });

  final String id;
  final String name;
  final String imageUrl;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}
