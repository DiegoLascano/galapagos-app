import 'package:flutter/foundation.dart';

class Island {
  factory Island.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) return null;
    final String name = data['name'];
    final String imageUrl = data['imageUrl'];
    final String description = data['description'];

    return Island(
      id: documentId,
      name: name,
      imageUrl: imageUrl,
      description: description,
    );
  }
  Island({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
    @required this.description,
  });
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
    };
  }
}
