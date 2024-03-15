// Import necessary package
import 'package:flutter/material.dart';  // Flutter Material package for UI

// Class for the screen allowing genre selection
class GenreSelectionScreen extends StatefulWidget {
  const GenreSelectionScreen({Key? key}) : super(key: key);  // Constructor for GenreSelectionScreen

  @override
  _GenreSelectionScreenState createState() => _GenreSelectionScreenState();  // Create state for GenreSelectionScreen
}

// State class for GenreSelectionScreen widget
class _GenreSelectionScreenState extends State<GenreSelectionScreen> {
  
  List<String> genres = ['Action', 'Adventure', 'Comedy', 'Drama', 'Sci-Fi', 'Family'];  // List of available genres
  
  List<String> selectedGenres = [];  // List to store selected genres

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  // Scaffold widget to create a basic layout structure
      appBar: AppBar(  // AppBar widget for the top app bar
        title: Text('Select Preferred Genres'),  // Title of the app bar
      ),
      body: ListView.builder(  
        itemCount: genres.length,  // Total number of genres
        itemBuilder: (context, index) {
          final genre = genres[index];  // Get genre at current index
          return CheckboxListTile(  // CheckboxListTile for each genre
            title: Text(genre),  // Title of the checkbox
            value: selectedGenres.contains(genre),  // Whether the genre is selected or not
            onChanged: (value) {  
              setState(() {  // Update UI state
                if (value != null && value) {  
                  selectedGenres.add(genre);  // Add genre to selected genres
                } else {  
                  selectedGenres.remove(genre);  // Remove genre from selected genres
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(  
        onPressed: () {  
          Navigator.pop(context, selectedGenres);  
        },
        child: Icon(Icons.check),  
      ),
    );
  }
}
