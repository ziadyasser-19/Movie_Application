// ignore_for_file: must_be_immutable

import 'package:Movie_App/widgets/downloadmoviecomponent.dart';
import 'package:flutter/material.dart';

class ListdownloadedMovies extends StatelessWidget {
  DownloadMovieComponent downloaded;

  ListdownloadedMovies({super.key, required this.downloaded});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
      child: SizedBox(
        height: screenHeight / 2,
        child: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: downloaded,
            );
          },
        ),
      ),
    );
  }
}
