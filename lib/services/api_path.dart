class APIPath {
  // For collections
  static String tours() => 'tours';
  // static String tours(String islandId) => 'islands/$islandId/tours';
  static String islands() => 'islands';
  static String sightseeings() => 'sightseeings';

  // For documents
  static String island(String islandId) => 'islands/$islandId';
  // static String tour(String islandId, String tourId) =>
  //     'islands/$islandId/activities/$tourId';
  static String tour(String tourId) => 'tours/$tourId';
}
