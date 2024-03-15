// Import necessary packages
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:shared_preferences/shared_preferences.dart';  // Package for storing preferences

// Class to manage favorite movies
class FavoritesManager {
  // Key to store favorites in SharedPreferences
  static const String _favoritesKey = 'favorites';

  // ValueNotifier to notify changes in favorites
  static final ValueNotifier<Set<String>> favoritesNotifier = ValueNotifier<Set<String>>({});

  // Function to get favorite movies from SharedPreferences
  static Future<Set<String>> getFavorites() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();
    // Get favorites set or initialize as empty set
    final favoritesSet = prefs.getStringList(_favoritesKey)?.toSet() ?? {};
    // Update favoritesNotifier value
    favoritesNotifier.value = favoritesSet;
    // Return favorites set
    return favoritesSet;
  }

  // Function to add a movie to favorites
  static Future<void> addFavorite(String movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = (prefs.getStringList(_favoritesKey) ?? []).toSet();
    if (favorites.add(movieId)) {
      await prefs.setStringList(_favoritesKey, favorites.toList());
      favoritesNotifier.value = favorites;
    }
  }

  // Function to remove a movie from favorites
  static Future<void> removeFavorite(String movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = (prefs.getStringList(_favoritesKey) ?? []).toSet();
    if (favorites.remove(movieId)) {
      await prefs.setStringList(_favoritesKey, favorites.toList());
      favoritesNotifier.value = favorites;
    }
  }
}
