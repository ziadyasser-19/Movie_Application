
import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/widgets/suggestionmoviecomponent.dart';
import 'package:flutter/material.dart';

class Similarmovielist extends StatefulWidget {
  final Movie movie;
  const Similarmovielist({super.key, required this.movie});

  @override
  State<Similarmovielist> createState() => _SimilarmovielistState();
}

class _SimilarmovielistState extends State<Similarmovielist> {
  late Future<List<Movie>> futureMovies;
  
  String userId = Session.currentUser!.id as String;

  @override
  void initState() {
    super.initState();
    _fetchMoviesForCategory(widget.movie.movietype);
  }

  
  void _fetchMoviesForCategory(String category) {
    setState(() {
      switch (category) {
        case "Action":
          futureMovies = fetchActionMovies(userId);
          break;
        case "Comedy":
          futureMovies = fetchComedyMovies(userId);
          break;
        case "Horror":
          futureMovies = fetchHorrorMovies(userId);
          break;
        case "Romantic":
          futureMovies = fetchRomanticMovies(userId);
          break;
        default:
          futureMovies = fetchMovies(userId); 
          break;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      child: SizedBox(
        height: screenHeight / 2,
        child: FutureBuilder<List<Movie>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No similar movies found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length ,
                itemBuilder: (context, index) {
                  final movie = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SuggestionMovieComponent(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      movieImage: NetworkImage(movie.imageURL),
                      movieEpisodeName: movie.movieName,
                      movieDescription: movie.aboutMovie,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}