import 'package:flutter/material.dart';  // Importing Flutter Material package for UI
import 'package:cineflix/models/movie.dart';  // Importing Movie class
import '../screens/details_screen.dart';  // Importing DetailsScreen for navigating to movie details
import 'package:cineflix/constants.dart';  // Importing constants.dart file for constants

// Class for a slider widget displaying trending movies
class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    Key? key,
    required this.movies,  // Required parameter for list of trending movies
  }) : super(key: key);

  final List<Movie> movies;  // List of trending movies to be displayed in the slider

  @override
  Widget build(BuildContext context) {
    return SizedBox(  // SizedBox to constrain the height and width of the slider
      height: 200,  // Height of the slider
      width: double.infinity,  // Width of the slider to occupy the available space
      child: ListView.builder(  // ListView.builder to create the horizontal slider
        scrollDirection: Axis.horizontal,  // Horizontal scroll direction
        physics: const BouncingScrollPhysics(),  // Bouncing scroll physics for a natural feel
        itemCount: movies.length,  // Number of movies in the list
        itemBuilder: (context, index) {  // Item builder for each movie
          return Padding(  // Padding around each movie item
            padding: const EdgeInsets.all(8.0),  // Padding of 8.0
            child: GestureDetector(  // GestureDetector to handle tap events
              onTap: () {  // Callback function when movie is tapped
                Navigator.push(  // Navigate to DetailsScreen when movie is tapped
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(  // DetailsScreen for displaying movie details
                      movie: movies[index],  // Pass the selected movie to DetailsScreen
                    ),
                  ),
                );
              },
              child: ClipRRect(  // ClipRRect to clip the image with rounded corners
                borderRadius: BorderRadius.circular(8),  // BorderRadius for rounded corners
                child: SizedBox(  // SizedBox to constrain the size of the image
                  height: 200,  // Height of the image
                  width: 150,  // Width of the image
                  child: Image.network(  // Image widget to display movie poster
                    '${Constants.imagePath}${movies[index].poster_path}',  // URL of the movie poster
                    filterQuality: FilterQuality.high,  // High filter quality for better image rendering
                    fit: BoxFit.cover,  // BoxFit.cover to cover the entire container with the image
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
