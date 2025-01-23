// ignore_for_file: must_be_immutable

import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/savedmovielist.dart';
import 'package:flutter/material.dart';

class Savedmovies extends StatefulWidget {

  const Savedmovies({super.key,});

  @override
  State<Savedmovies> createState() => _SavedmoviesState();
}

class _SavedmoviesState extends State<Savedmovies> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // test only this user
    String? userId = Session.currentUser!.id;

    void refreshPage() {
      setState(() {});
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Saved Movies",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              Container(
                height: screenHeight / 1.5 + 30,
                width: screenWidth,
                decoration: BoxDecoration(
                    color: Settings.Navigationbarcolor,
                    borderRadius: BorderRadius.circular(15)),
                child: SizedBox(
                  height: screenHeight / 1.252,
                  child: FutureBuilder<List<Movie>>(
                    future: fetchSavedMoviesForUser(userId!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Settings.binkthemecolor,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Helpers.noSavedFound(screenHeight, screenWidth);
                      } else {
                        return SavedMovieList(
                          userId: userId,
                          isSelected: refreshPage,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
