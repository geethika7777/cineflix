// Import necessary packages and files 
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:google_fonts/google_fonts.dart';  // Google Fonts package for font styling
import 'package:cineflix/api/api.dart';  // Importing API class for fetching movie data
import 'package:cineflix/models/movie.dart';  // Importing Movie model class
import 'package:cineflix/screens/GenreSelectionScreen.dart';  // Importing GenreSelectionScreen class

// Define a stateful widget for all movies screen
class AllMoviesScreen extends StatefulWidget {
  const AllMoviesScreen({Key? key}) : super(key: key);

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

// Define state class for AllMoviesScreen widget
class _AllMoviesScreenState extends State<AllMoviesScreen> {
  late Future<List<Movie>> movies;  // Future variable to hold movie data
  String? _selectedGenre;  // Variable to hold the selected genre

  
  @override
  void initState() {
    super.initState();
    // Fetch movies when the widget is initialized
    movies = Api().getMoviesByGenre([]);  // Fetch movies with empty genre list initially
  }

  // Function to fetch movies based on selected genres
  void fetchMovies({List<String>? genres}) {
    movies = Api().getMoviesByGenre(genres ?? []);  // Fetch movies with specified genres
    setState(() {}); 
  }

  // Build method to define the UI of the widget
  @override
  Widget build(BuildContext context) {
    // Basic layout structure
    return Scaffold(
      // AppBar widget for the top app bar
      appBar: AppBar(
        // Title of the app bar
        title: Text('All Movies', style: GoogleFonts.aBeeZee()),  // Set custom font for title
        // Actions in the app bar
        actions: <Widget>[
          // DropdownButton widget for genre selection
          DropdownButton<String>(
            hint: Text("Select genre"),  // Hint text for dropdown
            value: _selectedGenre,  // Currently selected genre
            // Callback function when a genre is selected
            onChanged: (newValue) {
              setState(() {
                _selectedGenre = newValue!;  // Update selected genre
                fetchMovies(genres: [_selectedGenre!]);  // Fetch movies for selected genre
              });
            },
            // List of genre items in the dropdown
            items: <String>['Action', 'Adventure', 'Comedy', 'Drama', 'Sci-Fi', 'Family']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),  // Display genre name
              );
            }).toList(),
          ),
        ],
      ),
      // Body of the screen
      body: FutureBuilder<List<Movie>>(
        future: movies,  // Future containing movie data
        // Builder function to build UI based on future state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display loading indicator while waiting for data
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Display error message if data fetching fails
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Display grid view of movies if data is available
            return GridView.builder(
              // Grid properties
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // Number of columns in the grid
                crossAxisSpacing: 10,  // Spacing between columns
                mainAxisSpacing: 10,  // Spacing between rows
                childAspectRatio: 0.6,  // Aspect ratio of grid items
              ),
              itemCount: snapshot.data!.length,  // Total number of items in the grid
              // Builder function to build each grid item
              itemBuilder: (context, index) {
                Movie movie = snapshot.data![index];  // Get movie data
                String imageUrl = movie.poster_path;  // Get movie poster URL

                // GridTile widget to display each grid item
                return GridTile(
                  child: Image.network(
                    imageUrl,  // Poster image URL
                    fit: BoxFit.cover,  // Image fit property
                    // Error handling for image loading failure
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Center(child: Text('Could not load poster'));
                    },
                  ),
                  // Footer of the grid item displaying movie title
                  footer: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      movie.title,  // Movie title
                      style: TextStyle(color: Colors.white, fontSize: 14),  // Text style
                      overflow: TextOverflow.ellipsis,  // Overflow behavior
                      maxLines: 2,  // Maximum lines for title
                      textAlign: TextAlign.center,  // Text alignment
                    ),
                  ),
                );
              },
            );
          } else {
            // Display message when no movies are found
            return Center(child: Text('No movies found'));
          }
        },
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          
        },
        child: const Icon(Icons.filter_list),  
        tooltip: 'Filter by Genre',  
      ),
    );
  }
}
