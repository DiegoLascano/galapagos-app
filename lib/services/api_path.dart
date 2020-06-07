class APIPath {
  // For collections
  static String activities(String islandId) => 'islands/$islandId/activities';
  static String islands() => 'islands';

  // For documents
  static String island(String islandId) => 'islands/$islandId';
  static String activity(String islandId, String activityId) =>
      'islands/$islandId/activities/$activityId';
}
