// TvShow class to represent TV show data
class TvShow {
  // Declare variabless
  String name;
  String backDropPath;
  String originalName;
  String overview;
  String posterPath;
  String firstAirDate;
  double voteAverage;

  // Constructor for the TvShow class
  TvShow({
    required this.name,
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
  });

  // Factory constructor to create a TvShow instance from a JSON object
  // This is used to convert the JSON data returned from an API call into a TvShow object
  factory TvShow.fromJson(Map<String, dynamic> json) {
    return TvShow(
      name: json["name"], 
      backDropPath: json["backdrop_path"] ?? '', 
      originalName: json["original_name"], 
      overview: json["overview"], 
      posterPath: json["poster_path"] ?? '', 
      firstAirDate: json["first_air_date"], 
      voteAverage: json["vote_average"].toDouble(), 
    );
  }

  
  get id => null;
}
