class Movie {
  final String id; // Add this field for MongoDB ObjectId
  final String imageURL;
  final String movieName;
  final String movietype;
  final DateTime moviedate;
  final String movietime;
  final List<String> listOfEpesoide;
  final String aboutMovie;

  Movie({
    required this.id, // Add this to the constructor
    required this.imageURL,
    required this.movieName,
    required this.movietype,
    required this.moviedate,
    required this.movietime,
    required this.listOfEpesoide,
    required this.aboutMovie,
  });

  // Factory method to create a Movie object from JSON
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['_id'], // MongoDB uses '_id' as the key for the ObjectId
      imageURL: json['imageURL'],
      movieName: json['MovieName'],
      movietype: json['movietype'],
      moviedate: DateTime.parse(json['moviedate']),
      movietime: json['movietime'],
      listOfEpesoide: List<String>.from(json['ListOfEpesoide']),
      aboutMovie: json['AboutMovie'],
    );
  }

  // Method to convert a Movie object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id, // Include the id in the JSON output
      'imageURL': imageURL,
      'MovieName': movieName,
      'movietype': movietype,
      'moviedate': moviedate.toIso8601String(),
      'movietime': movietime,
      'ListOfEpesoide': listOfEpesoide,
      'AboutMovie': aboutMovie,
    };
  }
}