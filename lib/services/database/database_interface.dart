import 'package:galapagos_touring/models/island_model.dart';

abstract class Database {
  // Future<void> setIsland(Island island);
  Stream<List<Island>> islandsStream();
}
