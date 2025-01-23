// ignore_for_file: unused_element, must_be_immutable

import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/view/moviedetailedview.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:flutter/material.dart';

class MovieComponent extends StatefulWidget {

  MovieComponent(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.movie,
      });

  final Movie movie;
  final double screenHeight;
  final double screenWidth;

  @override
  State<MovieComponent> createState() => _MovieComponentState();
}

class _MovieComponentState extends State<MovieComponent> {
  bool isSelected = false;

  Future<void> _isSelected() async {
    setState(() {
      isSelected = !isSelected;
    });

    try {
      if (isSelected) {
        await addMovieToSavedList(Session.currentUser!.id as String, widget.movie.id);
        Helpers.showCustomAlert(context, alerttext: "Movie Saved Succefully" , success: true);
      } else {
        await removeMovieFromSavedList(
            Session.currentUser!.id as String, widget.movie.id);
        Helpers.showCustomAlert(context, alerttext: "Movie removed !" , success: false);

      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isSelected = !isSelected;
      });
    }

  }

  void isSelectedOnly(){
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(
              movie: widget.movie,
              SavedState: isSelected,
              isSelected: _isSelected,
            ),
          ),
        );
      },
      child: Container(
        height: widget.screenHeight / 5 + 40,
        width: widget.screenWidth / 3 + 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 5,
              spreadRadius: 6,
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.movie.imageURL,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/default_image.png"),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                  icon: isSelected
                      ? const Icon(
                          weight: 20,
                          shadows: [
                            BoxShadow(
                                color: Color.fromARGB(255, 204, 83, 200),
                                blurRadius: 10,
                                spreadRadius: 20,
                                blurStyle: BlurStyle.solid)
                          ],
                          Icons.bookmark,
                          color: Color.fromARGB(255, 149, 22, 53),
                        )
                      : const Icon(
                          shadows: [
                            BoxShadow(
                                color: Color.fromARGB(255, 150, 8, 96),
                                blurRadius: 10,
                                spreadRadius: 20,
                                blurStyle: BlurStyle.solid)
                          ],
                          weight: 20,
                          Icons.bookmark_border,
                          color: Colors.white,
                        ),
                  onPressed: _isSelected),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                widget.movie.movieName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
