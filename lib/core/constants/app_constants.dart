class AppConstants {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  
  // Endpoints
  static const String searchEndpoint = '/search.php';
  static const String lookupEndpoint = '/lookup.php';
  static const String filterEndpoint = '/filter.php';
  static const String categoriesEndpoint = '/categories.php';
  static const String areaEndpoint = '/list.php?a=list';
  
  // Hive Boxes
  static const String favoritesBox = 'favorites_box';
  
  // App Strings
  static const String appName = 'Recipe Finder';
  static const String noInternetConnection = 'No internet connection';
  static const String unknownError = 'Something went wrong';
}
