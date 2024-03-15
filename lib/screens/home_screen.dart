// Import necessary packages and files
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:shared_preferences/shared_preferences.dart';  // Package for storing preferences
import 'package:cineflix/api/api.dart';  // Importing API for fetching movie data
import 'package:cineflix/models/movie.dart';  // Importing Movie model class
import 'package:cineflix/widgets/movies_slider.dart';  // Custom widget for displaying movies in a slider
import 'package:cineflix/widgets/trending_slider.dart';  // Custom widget for displaying trending movies in a slider
import 'package:google_fonts/google_fonts.dart';  // Google Fonts package for font styling
import 'favorites_screen.dart';  // Importing FavoritesScreen for displaying favorite movies
import 'search_screen.dart';  // Importing SearchScreen for searching movies
import 'AllMoviesScreen.dart';  // Importing AllMoviesScreen for displaying all movies
import 'login_page.dart';  // Importing LoginPage for handling user login

// Class for the home screen of the application
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);  // Constructor for HomeScreen

  @override
  State<HomeScreen> createState() => _HomeScreenState();  // Create state for HomeScreen
}

// State class for HomeScreen widget
class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;  // Fetching trending movies
  late Future<List<Movie>> topRatedMovies;  // Fetching top rated movies
  late Future<List<Movie>> upcomingMovies;  // Fetching upcoming movies

  @override
  void initState() {  
    fetchData();  // Fetch movie data
  }

  void fetchData() {  // Function to fetch movie data
    trendingMovies = Api().getTrendingMovies();  // Fetch trending movies
    topRatedMovies = Api().getTopRatedMovies();  // Fetch top rated movies
    upcomingMovies = Api().getUpcomingMovies();  // Fetch upcoming movies
  }

  Future<void> _logout(BuildContext context) async {  // Function to handle user logout
    final prefs = await SharedPreferences.getInstance();  // Get SharedPreferences instance
    await prefs.setBool('isLoggedIn', false);  // Set isLoggedIn to false
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));  // Navigate to login page
  }

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  
      appBar: AppBar(  // AppBar widget for the top app bar
        backgroundColor: Colors.transparent,  
        elevation: 0,  
        title: Image.asset(  // App logo in the title
          'assets/CINEFLIX-removebg-preview.png',  // Asset path for the logo
          fit: BoxFit.cover,  // Image fit property
          height: 180,  
          filterQuality: FilterQuality.high,  // Image filter quality
        ),
        centerTitle: true,  // Center align the title
        actions: <Widget>[  // Actions in the app bar
          IconButton(  // IconButton for search
            icon: const Icon(Icons.search),  // Icon for search
            tooltip: 'Search',  // Tooltip for search
            onPressed: () {  // Callback function when search icon is pressed
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SearchScreen()));  // Navigate to search screen
            },
          ),
          IconButton(  // IconButton for favorites
            icon: const Icon(Icons.favorite),  // Icon for favorites
            tooltip: 'Favorites',  // Tooltip for favorites
            onPressed: () {  // Callback function when favorites icon is pressed
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FavoritesScreen()));  // Navigate to favorites screen
            },
          ),
          IconButton(  // IconButton for all movies
            icon: const Icon(Icons.movie),  // Icon for all movies
            tooltip: 'All Movies',  // Tooltip for all movies
            onPressed: () {  // Callback function when all movies icon is pressed
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AllMoviesScreen()));  // Navigate to all movies screen
            },
          ),
          IconButton(  // IconButton for logout
            icon: const Icon(Icons.exit_to_app),  // Icon for logout
            tooltip: 'Logout',  // Tooltip for logout
            onPressed: () => _logout(context),  // Callback function when logout icon is pressed
          ),
        ],
      ),
      body: SingleChildScrollView(  // SingleChildScrollView for scrolling content
        physics: const BouncingScrollPhysics(),  // Bouncing scroll physics
        child: Padding(  // Padding around content
          padding: const EdgeInsets.all(8.0),  // Padding of 8.0
          child: Column(  // Column for arranging content vertically
            crossAxisAlignment: CrossAxisAlignment.start,  // Align content to the start (left) of the column
            children: [
              Text(  // Text widget for trending movies title
                'Trending Movies',  // Title for trending movies
                style: GoogleFonts.aBeeZee(fontSize: 25),  // Styling for the title text
              ),
              const SizedBox(height: 32),  // SizedBox for vertical spacing
              
              FutureBuilder<List<Movie>>(  // FutureBuilder for displaying trending movies
                future: trendingMovies,  // Future to wait for
                builder: (context, snapshot) {  // Builder function for handling snapshot
                  if (snapshot.hasError) {  // Check if there's an error in the snapshot
                    return Center(child: Text(snapshot.error.toString()));  // Display error message
                  } else if (snapshot.hasData) {  // Check if data is available in the snapshot
                    return TrendingSlider(movies: snapshot.data!);  // Display trending movies using TrendingSlider widget
                  } else {  // If data is not available yet
                    return const Center(child: CircularProgressIndicator());  // Display loading indicator
                  }
                },
              ),
              const SizedBox(height: 32),  // SizedBox for vertical spacing
              Text(  // Text widget for top rated movies title
                'Whats on TV Tonight',  // Title for top rated movies
                style: GoogleFonts.aBeeZee(fontSize: 25),  // Styling for the title text
              ),
              const SizedBox(height: 32),  // SizedBox for vertical spacing
              FutureBuilder<List<Movie>>(  // FutureBuilder for displaying top rated movies
                future: topRatedMovies,  // Future to wait for
                builder: (context, snapshot) {  // Builder function for handling snapshot
                  if (snapshot.hasError) {  // Check if there's an error in the snapshot
                    return Center(child: Text(snapshot.error.toString()));  // Display error message
                  } else if (snapshot.hasData) {  // Check if data is available in the snapshot
                    return MovieSlider(movies: snapshot.data!);  // Display top rated movies using MovieSlider widget
                  } else {  // If data is not available yet
                    return const Center(child: CircularProgressIndicator());  // Display loading indicator
                  }
                },
              ),
              const SizedBox(height: 32),  // SizedBox for vertical spacing
              Text(  // Text widget for upcoming movies title
                'Upcoming Movies',  // Title for upcoming movies
                style: GoogleFonts.aBeeZee(fontSize: 25),  // Styling for the title text
              ),
              const SizedBox(height: 32),  // SizedBox for vertical spacing
              FutureBuilder<List<Movie>>(  // FutureBuilder for displaying upcoming movies
                future: upcomingMovies,  // Future to wait for
                builder: (context, snapshot) {  // Builder function for handling snapshot
                  if (snapshot.hasError) {  // Check if there's an error in the snapshot
                    return Center(child: Text(snapshot.error.toString()));  // Display error message
                  } else if (snapshot.hasData) {  // Check if data is available in the snapshot
                    return MovieSlider(movies: snapshot.data!);  // Display upcoming movies using MovieSlider widget
                  } else {  // If data is not available yet
                    return const Center(child: CircularProgressIndicator());  // Display loading indicator
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
