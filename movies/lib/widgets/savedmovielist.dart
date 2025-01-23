// ignore_for_file: must_be_immutable

import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/widgets/savedmoviecomponent.dart';
import 'package:flutter/material.dart';

class SavedMovieList extends StatefulWidget {
  final String userId;
  VoidCallback isSelected;
  
  SavedMovieList({super.key, required this.userId , required this.isSelected});

  @override
  State<SavedMovieList> createState() => _SavedMovieListState();
}

class _SavedMovieListState extends State<SavedMovieList> {
  late Future<List<Movie>> futureSavedMovies;

  @override
  void initState() {
    super.initState();
    _fetchSavedMoviesForUser(widget.userId);
  }

  void _fetchSavedMoviesForUser(String userId) {
    setState(() {
      futureSavedMovies = fetchSavedMoviesForUser(userId);
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
          future: futureSavedMovies,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No saved movies found.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final movie = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SavedMovieComponent(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      savedMovie: movie,
                      isSelected: widget.isSelected,
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