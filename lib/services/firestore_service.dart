import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  Future<void> setData({String path, Map<String, dynamic> data}) async {
    final documentReference = Firestore.instance.document(path);
//    print('$path: $data');
    await documentReference.setData(data);
  }

  // Stream<List<T>> collectionStream<T>({
  //   @required String path,
  //   @required T builder(Map<String, dynamic> data, String documentId),
  // }) {
  //   final reference = Firestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map(
  //     (collectionSnapshot) => collectionSnapshot.documents
  //         .map((documentSnapshot) =>
  //             builder(documentSnapshot.data, documentSnapshot.documentID))
  //         .toList(),
  //   );
  // }

  // Read a record in firestore
  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query) queryBuilder,
    int Function(T lhs, T rhs) sort,
//    @required T builder(Map<String, dynamic> data, String documentId),
//    Query queryBuilder(Query query),
//    int sort(T lhs, T rhs),
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((collectionSnapshot) {
      final result = collectionSnapshot.documents
          .map((documentSnapshot) =>
              builder(documentSnapshot.data, documentSnapshot.documentID))
          .where((value) => value != null)
          .toList();
      // if (sort != null) {
      //   result.sort(sort);
      // }
//      print(result);
      return result;
    });
  }

  Stream<T> documentStream<T>({
    @required String path,
    T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = Firestore.instance.document(path);
    final documentSnapshot = reference.snapshots();
    return documentSnapshot.map((documentSnapshot) =>
        builder(documentSnapshot.data, documentSnapshot.documentID));
  }
}
