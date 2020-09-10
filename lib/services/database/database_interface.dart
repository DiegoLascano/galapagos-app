import 'package:galapagos_touring/models/island_model.dart';
import 'package:galapagos_touring/models/sightseeing_model.dart';
import 'package:galapagos_touring/models/tour_model.dart';

abstract class Database {
  // Future<void> setIsland(Island island);
  Stream<List<Island>> islandsStream();
  Stream<List<Tour>> toursStream({Island island});
  Stream<List<Sightseeing>> sightseeingsStream();

//  unused after refactor
//  Stream<Tour> tourStream({Tour tour});
}
