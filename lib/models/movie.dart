// Movie class to represent movie data
class Movie{
  // Declare variables 
  String title;
  String backDropPath;
  String originalTitle;
  String overview;
  String poster_path;
  String releaseDate;
  double vote_average;

  // Constructor for the Movie class
  Movie({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.poster_path,
    required this.releaseDate,
    required this.vote_average,
  });

  // Factory constructor to create a Movie instance from a JSON object
  // This is used to parse the JSON data returned from an API call into a Movie object
  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      title: json["title"], 
      backDropPath: json["backdrop_path"], 
      originalTitle: json["original_title"], 
      overview: json["overview"], 
      poster_path: json["poster_path"], 
      releaseDate: json["release_date"], 
      vote_average: json["vote_average"], 
    );
  }

  // Placeholder getter for an id prop(check)
  
  get id => null;
}
