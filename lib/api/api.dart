// Import necessary Dart and Flutter packages 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cineflix/constants.dart'; 
import 'package:cineflix/models/movie.dart';
import 'package:cineflix/models/tv_show.dart'; 

// Define the Api class that contains methods to fetch data from the Movie Database API
class Api {
  // Base URL and API key for accessing The Movie Database API
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = Constants.apiKey;

  // Helper method to process the HTTP response and extract the 'results' data
  Future<List<dynamic>> _processHttpResponse(http.Response response) async {
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['results'];
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // Fetch movies that are suitable for children by specifying genres
  Future<List<Movie>> fetchChildFriendlyMovies() async {
    final url = Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=16,10751,14,12');
    final response = await http.get(url);
    final result = await _processHttpResponse(response);
    return result.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
  
  // Fetch movies that are trending today
  Future<List<Movie>> getTrendingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'));
    final List<dynamic> results = await _processHttpResponse(response);
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  // Fetch movies that are top-rated
  Future<List<Movie>> getTopRatedMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'));
    final List<dynamic> results = await _processHttpResponse(response);
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  // Fetch movies that are upcoming
  Future<List<Movie>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey'));
    final List<dynamic> results = await _processHttpResponse(response);
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  // Fetch movies by a list of specified genres
  Future<List<Movie>> getMoviesByGenre(List<String> genres) async {
    final genresQueryParam = genres.join(',');
    final response = await http.get(Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genresQueryParam'));
    final List<dynamic> results = await _processHttpResponse(response);
    return results.map((json) => Movie.fromJson(json)).toList();
  }

  // Search for movies based on a query string
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=${Uri.encodeComponent(query)}');
    final response = await http.get(url);
    final results = await _processHttpResponse(response);
    return results.map<Movie>((json) => Movie.fromJson(json)).toList();
  }

  // Search for TV shows based on a query string
  Future<List<TvShow>> searchTvShows(String query) async {
    final url = Uri.parse('$baseUrl/search/tv?api_key=$apiKey&query=${Uri.encodeComponent(query)}');
    final response = await http.get(url);
    final results = await _processHttpResponse(response);
    return results.map<TvShow>((json) => TvShow.fromJson(json)).toList();
  }

  // Fetch the latest movies
  Future<List<Movie>> getLatestMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movie/latest?api_key=$apiKey'));
    final List<dynamic> results = await _processHttpResponse(response);
    return results.map((json) => Movie.fromJson(json)).toList();
  }
}
