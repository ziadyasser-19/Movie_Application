import 'dart:convert';
import 'package:Movie_App/models/Users.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:http/http.dart' as http;

// Base URL
const String baseUrl = 'http://192.168.56.1:3000';

// Get 20 movies excluding saved movies
Future<List<Movie>> fetchMovies(String userId) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/movies/$userId'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load movies: $e');
  }
}

// Fetch Action movies
Future<List<Movie>> fetchActionMovies(String userId) async {
  try {
    final response =
        await http.get(Uri.parse('$baseUrl/movies/$userId/action'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load Action movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load Action movies: $e');
  }
}

// Fetch Romantic movies
Future<List<Movie>> fetchRomanticMovies(String userId) async {
  try {
    final response =
        await http.get(Uri.parse('$baseUrl/movies/$userId/romantic'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load Romantic movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load Romantic movies: $e');
  }
}

// Fetch Horror movies
Future<List<Movie>> fetchHorrorMovies(String userId) async {
  try {
    final response =
        await http.get(Uri.parse('$baseUrl/movies/$userId/horror'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load Horror movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load Horror movies: $e');
  }
}

// Fetch Comedy movies
Future<List<Movie>> fetchComedyMovies(String userId) async {
  try {
    final response =
        await http.get(Uri.parse('$baseUrl/movies/$userId/comedy'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load Comedy movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load Comedy movies: $e');
  }
}


// Fetch movies by name, excluding saved movies
Future<List<Movie>> fetchSearchMovies(String userId, String movieName) async {
  try {
    
    final response = await http.get(
      Uri.parse('$baseUrl/search-movie/$userId?MovieName=$movieName'),
    );

    if (response.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> responseBody = json.decode(response.body);

      // Extract the list of movies from the response
      final List<dynamic> moviesJson = responseBody['movies'];

      // Convert the JSON list to a list of Movie objects
      return moviesJson.map((movie) => Movie.fromJson(movie)).toList();
    } else if (response.statusCode == 404) {
      // Handle the case where no movies are found
      throw Exception('No movies found with the name: $movieName');
    } else {
      // Handle other HTTP errors
      throw Exception('Failed to load search results: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any other errors
    throw Exception('Failed to load search results: $e');
  }
}
//================================================
//============Users Services====================

Future<List<Movie>> fetchSavedMoviesForUser(String userId) async {
  try {
    final response =
        await http.get(Uri.parse('$baseUrl/users/$userId/saved-movies'));

    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> savedMoviesJson = data['savedMovies'];

      // Convert JSON to List<Movie>
      return savedMoviesJson
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception('Failed to fetch saved movies: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to fetch saved movies: $e');
  }
}

Future<void> addMovieToSavedList(String userId, String movieId) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/users/$userId/save-movie'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'movieId': movieId}),
    );

    if (response.statusCode == 200) {
      print('Movie added to saved list successfully');
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception(
          'Failed to add movie to saved list: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to add movie to saved list: $e');
  }
}

Future<void> removeMovieFromSavedList(String userId, String movieId) async {
  try {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId/remove-movie'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'movieId': movieId}),
    );

    if (response.statusCode == 200) {
      print('Movie removed from saved list successfully');
    } else if (response.statusCode == 404) {
      throw Exception('User not found');
    } else {
      throw Exception(
          'Failed to remove movie from saved list: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to remove movie from saved list: $e');
  }
}

// Function to log in a user
Future<User> loginUser(String username, String password) async {
  try {
    // Send a POST request to the login endpoint
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Parse the response body into a User object
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return User.fromJson(responseBody['user']);
    } else {
      // Handle errors
      throw Exception('Failed to log in: ${response.statusCode}');
    }
  } catch (e) {
    // Handle exceptions
    throw Exception('Failed to log in: $e');
  }
}

// Function to sign up a user
Future<User> signupUser(String username, String password) async {
  try {
    // Send a POST request to the signup endpoint
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      // Parse the response body into a User object
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return User.fromJson(responseBody['user']);
    } else if (response.statusCode == 409) {
      throw Exception('Username already exist');
    } else {
      // Handle errors
      throw Exception('Failed to sign up: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions
    throw Exception('Failed to sign up: $e');
  }
}
