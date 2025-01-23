// ignore_for_file: must_be_immutable

import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/widgets/suggestionmoviecomponent.dart';
import 'package:flutter/material.dart';

class Episodemovies extends StatelessWidget {
  Movie movie;
  Episodemovies({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      child: movie.listOfEpesoide.isEmpty
          ? const Center(
              child: Text(
              "No Episode For This Movie",
              style: Settings.menuText,
            ))
          : SizedBox(
              height: screenHeight / 2,
              child: ListView.builder(
                itemCount: movie.listOfEpesoide.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SuggestionMovieComponent(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        movieImage: NetworkImage(movie.imageURL),
                        movieEpisodeName: movie.listOfEpesoide[index],
                        movieDescription: movie.aboutMovie),
                  );
                },
              ),
            ),
    );
  }
}
