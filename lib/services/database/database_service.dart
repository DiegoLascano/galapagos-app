import 'package:flutter/foundation.dart';

import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/models/sightseeing_model.dart';
import 'package:galapagos_touring/models/tour_model.dart';
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

  // Fetches all records from the path specified
  @override
  Stream<List<Island>> islandsStream() => _firestoreService.collectionStream(
        path: APIPath.islands(),
        builder: (data, documentId) => Island.fromMap(data, documentId),
      );

  // // Fetches all Tours from the Island specified
  // @override
  // Stream<List<Tour>> toursStream(Island island) =>
  //     _firestoreService.collectionStream(
  //       path: APIPath.tours(),
  //       builder: (data, documentId) => Tour.fromMap(data, documentId),
  //     );

  // Fetches all records from the Tour specified in the path
//  Not needed after refactor
//  @override
//  Stream<Tour> tourStream({@required Tour tour}) =>
//      _firestoreService.documentStream(
//        path: APIPath.tour(tour.id),
//        builder: (data, documentId) => Tour.fromMap(data, documentId),
//      );

  // Fetches all entries from the specified job (and user)
  @override
  Stream<List<Tour>> toursStream({@required Island island}) =>
      _firestoreService.collectionStream<Tour>(
        path: APIPath.tours(),
        queryBuilder: island != null
            ? (query) => query.where('islandId', isEqualTo: island.id)
            : null,
        builder: (data, documentID) => Tour.fromMap(data, documentID),
      );

  // Fetches all records from the path specified
  @override
  Stream<List<Sightseeing>> sightseeingsStream() =>
      _firestoreService.collectionStream(
        path: APIPath.sightseeings(),
        builder: (data, documentId) => Sightseeing.fromMap(data, documentId),
      );
}
