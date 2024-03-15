import 'package:shared_preferences/shared_preferences.dart';  // Importing shared_preferences package for managing local storage

// Class for managing favorites using SharedPreferences
class FavoritesManager {
  static const String _favoritesKey = 'favorites';  // Key for storing favorites in SharedPreferences

  // Asynchronous function to get the set of favorite movie IDs
  static Future<Set<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();  // Get instance of SharedPreferences
    return prefs.getStringList(_favoritesKey)?.toSet() ?? {};  // Get favorite movie IDs or return an empty set if null
  }

  // Asynchronous function to add a movie to favorites
  static Future<bool> addFavorite(String movieId) async {
    final prefs = await SharedPreferences.getInstance();  // Get instance of SharedPreferences
    final favorites = (prefs.getStringList(_favoritesKey) ?? []).toSet();  // Get current favorites or create an empty set
    final result = favorites.add(movieId);  // Add movie ID to favorites
    await prefs.setStringList(_favoritesKey, favorites.toList());  // Save updated favorites to SharedPreferences
    return result;  // Return true if movie ID was added successfully
  }

  // Asynchronous function to remove a movie from favorites
  static Future<bool> removeFavorite(String movieId) async {
    final prefs = await SharedPreferences.getInstance();  // Get instance of SharedPreferences
    final favorites = (prefs.getStringList(_favoritesKey) ?? []).toSet();  // Get current favorites or create an empty set
    final result = favorites.remove(movieId);  // Remove movie ID from favorites
    await prefs.setStringList(_favoritesKey, favorites.toList());  // Save updated favorites to SharedPreferences
    return result;  // Return true if movie ID was removed successfully
  }
}
