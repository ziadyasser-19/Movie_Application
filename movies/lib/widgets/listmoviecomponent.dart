// ignore_for_file: must_be_immutable

import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/moviecomponent.dart';
import 'package:flutter/material.dart';

class ListMovieComponent extends StatelessWidget {
  
  final List<Movie> movies;
  final String textAboveList;
  

  ListMovieComponent({
    super.key,
    required this.movies,
    required this.textAboveList,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Helpers.textBetweenMovies(
          text: textAboveList,
          screenHeight: screenHeight,
        ),
        SizedBox(
          height: screenHeight / 5 + 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: MovieComponent(
                  screenHeight: screenHeight,
                  screenWidth: MediaQuery.of(context).size.width,
                  movie: movies[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}