class User {
  final String? id; // Make fields nullable
  final String? username;
  final String? password;
  final List<String>? listOfMoviesId;

  User({
    this.id,
    this.username,
    this.password,
    this.listOfMoviesId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'], // Ensure this matches the server response
      username: json['username'],
      password: json['password'],
      listOfMoviesId: json['ListOfMoviesId'] != null
          ? List<String>.from(json['ListOfMoviesId'])
          : [], // Handle null ListOfMoviesId
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'password': password,
      'ListOfMoviesId': listOfMoviesId,
    };
  }
}