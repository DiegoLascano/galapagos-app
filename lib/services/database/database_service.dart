import 'package:flutter/foundation.dart';

import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/services/api_path.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
import 'package:galapagos_touring/services/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

class FirestoreDatabase implements Database {
  FirestoreDatabase({
    @required this.uid,
  }) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;

  // Creates a single island with the given information
  // Future<void> setIsland(Island island) async => _firestoreService.setData(
  //       path: APIPath.island(uid, island.id),
  //       data: island.toMap(),
  //     );

  // Fetches all records from the path especified
  @override
  Stream<List<Island>> islandsStream() => _firestoreService.collectionStream(
        path: APIPath.islands(),
        builder: (data, documentId) => Island.fromMap(data, documentId),
      );
}
