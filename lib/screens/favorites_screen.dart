// Import necessary packages and files
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'favorites_manager.dart';  // Importing favorites manager for handling favorite movies

// Class for the screen displaying favorite movies
class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();  // Create state for FavoritesScreen
}

// State class for FavoritesScreen widget
class _FavoritesScreenState extends State<FavoritesScreen> {
  late ValueNotifier<Set<String>> favoriteMoviesIdsNotifier;  // ValueNotifier for favorite movie IDs

  @override
  void initState() {  // Initialize state of the widget
    super.initState();
    // Initialize favoriteMoviesIdsNotifier with empty set
    favoriteMoviesIdsNotifier = ValueNotifier<Set<String>>({});
    _loadFavorites();  // Load favorite movies
  }

  // Function to load favorite movies
  void _loadFavorites() async {
    final ids = await FavoritesManager.getFavorites();  // Get favorite movie IDs
    setState(() {
      favoriteMoviesIdsNotifier.value = ids;  // Update favoriteMoviesIdsNotifier value
    });
  }

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  // Scaffold widget to create a basic layout structure
      appBar: AppBar(  
        title: Text('Favorite Movies'),  
      ),
      body: ValueListenableBuilder<Set<String>>(  // ValueListenableBuilder to listen for changes in favoriteMoviesIdsNotifier
        valueListenable: favoriteMoviesIdsNotifier,  // ValueNotifier to listen for changes
        builder: (context, ids, _) {
          if (ids.isEmpty) {  // Check if there are no favorite movies
            return Center(child: Text('No favorites yet'));  // Display message for no favorites
          } else {
            return GridView.builder(  // GridView.builder for displaying favorite movies in grid
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  
                crossAxisSpacing: 8,  
                mainAxisSpacing: 8,  
                childAspectRatio: 0.7,  
              ),
              itemCount: ids.length,  // Total number of favorite movies
              itemBuilder: (context, index) {
                String movieId = ids.elementAt(index);  // Get movie ID
                return GestureDetector(  // GestureDetector for handling tap events
                  onTap: () async {  // Callback function when a movie is tapped
                    if (ids.contains(movieId)) {  // Check if movie is already a favorite
                      await FavoritesManager.removeFavorite(movieId);  // Remove movie from favorites
                    } else {
                      await FavoritesManager.addFavorite(movieId);  // Add movie to favorites
                    }
                    _loadFavorites();  // Reload favorite movies
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],  // Background color of grid item
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage('https://via.placeholder.com/150'),  // Placeholder image
                              fit: BoxFit.cover,  // Image fit property
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Movie ID: $movieId',  // Display movie ID
                            style: TextStyle(
                              fontWeight: FontWeight.bold,  // Font weight of movie ID text
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
