// Import necessary packages and files
import 'package:flutter/material.dart';  // Flutter Material package for UI
import 'package:google_fonts/google_fonts.dart';  // Google Fonts package for font styling
import 'package:cineflix/colors.dart';  // Custom color constants
import 'package:cineflix/constants.dart';  // Custom constant values
import 'package:cineflix/models/movie.dart';  // Importing Movie model class
import 'package:cineflix/widgets/back_button.dart';  // Importing custom back button widget
import 'favorites_manager.dart';  // Importing favorites manager for handling favorite movies

// Define a stateful widget for the screen displaying movie details
class DetailsScreen extends StatefulWidget {
  final Movie movie;  // Movie object to display details

  const DetailsScreen({  // Constructor for DetailsScreen
    super.key,
    required this.movie,  // Required parameter: movie
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();  // Create state for DetailsScreen
}

// Define state class for DetailsScreen widget
class _DetailsScreenState extends State<DetailsScreen> {
  late bool isFavorite;  // Variable to track if movie is favorite or not

  @override
  void initState() {  // Initialize state of the widget
    super.initState();
    _checkFavoriteStatus();  // Check if the movie is already a favorite
  }

  // Function to check if the movie is already marked as favorite
  void _checkFavoriteStatus() async {
    final favorites = await FavoritesManager.getFavorites();  // Get list of favorite movies
    setState(() {
      isFavorite = favorites.contains(widget.movie.id.toString());  // Check if movie ID is in favorites
    });
  }

  // Function to toggle movie as favorite or remove from favorites
  void _toggleFavorite() async {
    if (isFavorite) {
      await FavoritesManager.removeFavorite(widget.movie.id.toString());  // Remove from favorites
    } else {
      await FavoritesManager.addFavorite(widget.movie.id.toString());  // Add to favorites
    }
    _checkFavoriteStatus();  // Update favorite status
  }

  @override
  Widget build(BuildContext context) {  // Build method to define the UI of the widget
    return Scaffold(  // Basic layout structure
      body: CustomScrollView(  // CustomScrollView for flexible scrolling behavior
        slivers: [
          SliverAppBar.large(  // SliverAppBar for a scrollable app bar with flexible space
            leading: const BackBtn(),  // Custom back button widget
            backgroundColor: Colours.scaffoldBgColor,  // Background color of the app bar
            expandedHeight: 500, 
            pinned: true,  
            floating: true,  
            actions: [  
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,  // Display favorite icon based on favorite status
                  color: Colors.red,  
                ),
                onPressed: _toggleFavorite,  // Toggle favorite status when icon is pressed
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(  // FlexibleSpaceBar for flexible app bar content
              title: Text(
                widget.movie.title,  // Title of the movie
                style: GoogleFonts.belleza(  
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              background: ClipRRect(  // Rounded corners
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${widget.movie.poster_path}',  // Movie poster image URL
                  filterQuality: FilterQuality.high,  // Image filter quality
                  fit: BoxFit.cover,  // Image fit property
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(  // SliverToBoxAdapter for non-scrollable box children
            child: Padding(
              padding: const EdgeInsets.all(12),  // Padding for content
              child: Column(
                children: [
                  Text(
                    'Overview',  // Section title
                    style: GoogleFonts.openSans(  // Custom font styling for section title
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),  // Spacer
                  Text(
                    widget.movie.overview,  // Movie overview text
                    style: GoogleFonts.roboto(  // Custom font styling for movie overview
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),  // Spacer
                  _buildInfoRow('Release date: ', widget.movie.releaseDate),  // Build info row for release date
                  const SizedBox(height: 8),  // Spacer
                  _buildRatingRow(widget.movie.vote_average),  // Build info row for movie rating
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build a row for displaying movie information
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,  // Label for the information
          style: GoogleFonts.roboto(  // Custom font styling for label
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,  // Value of the information
          style: GoogleFonts.roboto(  // Custom font styling for value
            fontSize: 17,
          ),
        ),
      ],
    );
  }

  // Function to build a row for displaying movie rating
  Widget _buildRatingRow(double rating) {
    return Row(
      children: [
        Text(
          'Rating: ',  // Label for movie rating
          style: GoogleFonts.roboto(  // Custom font styling for label
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(
          Icons.star,  // Star icon for rating
          color: Colors.amber,  // Color of the star icon
        ),
        Text(
          '${rating.toStringAsFixed(1)}/10',  // Movie rating
          style: GoogleFonts.roboto(  // Custom font styling for rating
            fontSize: 17,
          ),
        ),
      ],
    );
  }
}
