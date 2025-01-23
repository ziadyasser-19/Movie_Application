import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/widgets/customtextfield.dart';
import 'package:Movie_App/widgets/listmoviecomponent.dart';
import 'package:Movie_App/widgets/savedhelpers.dart';
import 'package:flutter/material.dart';

class SearchMovie extends StatefulWidget {
  const SearchMovie({super.key});

  @override
  State<SearchMovie> createState() => _SearchMovieState();
}

class _SearchMovieState extends State<SearchMovie> {
  bool isFound = false;
  bool startState = true;
  List<Movie> movies = [];
  final TextEditingController userSearch = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validateSearch() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        startState = false;
      });

      try {
        List<Movie> fetchedMovies = await fetchSearchMovies(
          Session.currentUser!.id as String,
          userSearch.text,
        );

        setState(() {
          isFound = fetchedMovies.isNotEmpty;
          movies = fetchedMovies;
        });
      } catch (e) {
        setState(() {
          isFound = false;
        });
      }
    } else {
      setState(() {
        startState = true;
        isFound = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // Split the movies list into two parts
    List<Movie> firstFourMovies = movies.length > 4 ? movies.sublist(0, 4) : movies;
    List<Movie> remainingMovies = movies.length > 4 ? movies.sublist(4) : [];

    return Scaffold(
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Customtextfield(
              screenWidth: screenWidth,
              errorText: "Enter Search input",
              hintText: "Search for a movie",
              suffixIcon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 20,
              ),
              ObsecureText: false,
              upperText: "",
              controller: userSearch,
              onTap: validateSearch,
            ),
          ),
          const SizedBox(height: 20),
          startState
              ? const SizedBox.shrink()
              : isFound
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // First ListMovieComponent (first 4 movies)
                            if (firstFourMovies.isNotEmpty)
                              ListMovieComponent(
                                movies: firstFourMovies,
                                textAboveList: "Movies Found",
                              ),
                            // Second ListMovieComponent (remaining movies)
                            if (remainingMovies.isNotEmpty)
                              ListMovieComponent(
                                movies: remainingMovies,
                                textAboveList: "More Movies",
                              ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  : Savedhelpers.noMovieFound(
                      screenheight: screenHeight, screenWidth: screenWidth),
        ],
      ),
    );
  }
}