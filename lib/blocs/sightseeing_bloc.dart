import 'package:flutter/foundation.dart';
import 'package:galapagos_touring/models/sightseeing_model.dart';
import 'package:galapagos_touring/models/tour_model.dart';
import 'package:galapagos_touring/services/database/database_interface.dart';
//import 'package:rxdart/rxdart.dart';

class SightseeingBloc {
  SightseeingBloc({
    @required this.database,
    @required this.tour,
  });

  final Database database;
  final Tour tour;

  Stream<List<Sightseeing>> get tourSightseeing =>
      database.sightseeingsStream().map((sightseeings) {
        return tour.sightseeing.map((tourSightseeing) {
          final sightseeing = sightseeings?.firstWhere(
              (sightseeing) => sightseeing.id == tourSightseeing,
              orElse: () => null);
          return sightseeing;
        }).toList();
      });
//  /// combine List<Sightseeing>, Tour into List<Sightseeing>
//  Stream<List<Sightseeing>> tourSightseeings(Tour tour) => Rx.combineLatest2(
//        database.sightseeingsStream(),
//        database.tourStream(tour: tour),
//        _sightseeingsTourCombiner,
//      );
//
//  static List<Sightseeing> _sightseeingsTourCombiner(
//      List<Sightseeing> sightseeings, Tour tour) {
//    return tour.sightseeing.map((tourSightseeing) {
//      final sightseeing = sightseeings?.firstWhere(
//          (sightseeing) => sightseeing.id == tourSightseeing,
//          orElse: () => null);
//      return sightseeing;
//    }).toList();
//  }
}
