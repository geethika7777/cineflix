// Import necessary packages and files
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:cineflix/api/api.dart';  // Importing API for searching movies and TV shows
import 'package:cineflix/models/movie.dart';  // Importing Movie model
import 'package:cineflix/models/tv_show.dart';  // Importing TVShow model

// Class for the search screen of the application
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);  // Constructor for SearchScreen

  @override
  State<SearchScreen> createState() => _SearchScreenState();  // Create state for SearchScreen
}

// State class for SearchScreen widget
class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchQueryController = TextEditingController();  // Controller for search query
  Future<List<Movie>>? _searchResultsMovies;  // Future for storing search results for movies
  Future<List<TvShow>>? _searchResultsTvShows;  // Future for storing search results for TV shows
  bool _isSearching = false;  // Flag to indicate if search is in progress

  void _startSearch(String query) {  // Function to initiate search
    setState(() {
      _isSearching = true;  // Set searching flag to true
      _searchResultsMovies = Api().searchMovies(query);  // Search for movies based on query
      _searchResultsTvShows = Api().searchTvShows(query);  // Search for TV shows based on query
    });
  }

  @override
  void dispose() {
    _searchQueryController.dispose();  // Dispose the search query controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return DefaultTabController(  // DefaultTabController for managing tabs
      length: 2,  // Number of tabs
      child: Scaffold(  // Scaffold widget to create a basic layout structure
        appBar: AppBar(  // AppBar widget for the top app bar
          title: const Text('Search'),  // Title of the app bar
          bottom: const TabBar(  // TabBar for switching between movies and TV shows
            tabs: [
              Tab(icon: Icon(Icons.movie), text: 'Movies'),  // Tab for movies
              Tab(icon: Icon(Icons.tv), text: 'TV Shows'),  // Tab for TV shows
            ],
          ),
        ),
        body: Column(  // Column for arranging content vertically
          children: [
            Padding(  // Padding around search bar
              padding: const EdgeInsets.all(16.0),  // Padding of 16.0
              child: TextField(  // TextField widget for search input
                controller: _searchQueryController,  // Controller for search input
                decoration: InputDecoration(  // Decoration for search input
                  hintText: 'Search Movies or TV Shows...',  // Hint text for search input
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),  // Border decoration
                  suffixIcon: IconButton(  // IconButton for search action
                    icon: const Icon(Icons.search),  // Icon for search action
                    onPressed: () {  // Callback function when search button is pressed
                      if (_searchQueryController.text.isNotEmpty) {  // Check if search query is not empty
                        _startSearch(_searchQueryController.text);  // Initiate search
                      }
                    },
                  ),
                ),
                onSubmitted: (query) {  // Callback function when search is submitted
                  if (query.isNotEmpty) {  // Check if search query is not empty
                    _startSearch(query);  // Initiate search
                  }
                },
              ),
            ),
            Expanded(  // Expanded widget to take remaining space
              child: TabBarView(  // TabBarView for displaying search results based on tabs
                children: [
                  // FutureBuilder for displaying search results for movies
                  FutureBuilder<List<Movie>>(
                    future: _searchResultsMovies,  // Future to wait for
                    builder: (context, snapshot) {  // Builder function for handling snapshot
                      // Check different states of the snapshot
                      if (!_isSearching) {  // If not searching yet
                        return const Center(child: Text('Search for movies'));  // Display message to search for movies
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {  // If waiting for data
                        return const Center(child: CircularProgressIndicator());  // Display loading indicator
                      }
                      if (snapshot.hasError) {  // If error occurred
                        return Center(child: Text('Error: ${snapshot.error}'));  // Display error message
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {  // If no data found
                        return const Center(child: Text('No results found'));  // Display message for no results
                      }
                      // Display ListView of search results for movies
                      return ListView.builder(
                        itemCount: snapshot.data!.length,  // Number of items in the list
                        itemBuilder: (context, index) {  // Builder function for each item
                          var movie = snapshot.data![index];  // Get movie at current index
                          return ListTile(  // ListTile for displaying movie information
                            title: Text(movie.title ?? 'No Title'),  // Display movie title
                            subtitle: Text(movie.overview ?? 'No Description'),  // Display movie overview
                          );
                        },
                      );
                    },
                  ),
                  // FutureBuilder for displaying search results for TV shows
                  FutureBuilder<List<TvShow>>(
                    future: _searchResultsTvShows,  // Future to wait for
                    builder: (context, snapshot) {  // Builder function for handling snapshot
                      // Check different states of the snapshot
                      if (!_isSearching) {  // If not searching yet
                        return const Center(child: Text('Search for TV shows'));  // Display message to search for TV shows
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {  // If waiting for data
                        return const Center(child: CircularProgressIndicator());  // Display loading indicator
                      }
                      if (snapshot.hasError) {  // If error occurred
                        return Center(child: Text('Error: ${snapshot.error}'));  // Display error message
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {  // If no data found
                        return const Center(child: Text('No results found'));  // Display message for no results
                      }
                      // Display ListView of search results for TV shows
                      return ListView.builder(
                        itemCount: snapshot.data!.length,  // Number of items in the list
                        itemBuilder: (context, index) {  // Builder function for each item
                          var tvShow = snapshot.data![index];  // Get TV show at current index
                          return ListTile(  // ListTile for displaying TV show information
                            title: Text(tvShow.name ?? 'No Title'),  // Display TV show name
                            subtitle: Text(tvShow.overview ?? 'No Description'),  // Display TV show overview
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
