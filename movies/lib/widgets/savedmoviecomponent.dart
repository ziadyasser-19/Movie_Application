// ignore_for_file: must_be_immutable

import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/view/moviedetailedview.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:flutter/material.dart';

class SavedMovieComponent extends StatefulWidget {
  final Movie savedMovie;
  final double screenHeight;
  final double screenWidth;
  VoidCallback isSelected;
  SavedMovieComponent(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.savedMovie,
      required this.isSelected});

  @override
  State<SavedMovieComponent> createState() => _SavedMovieComponentState();
}

class _SavedMovieComponentState extends State<SavedMovieComponent> {
  bool isSelected = true;

  Future<void> _isSelected() async {
    setState(() {
      isSelected = !isSelected;
    });

    try {
      if (isSelected) {
        await addMovieToSavedList(
            Session.currentUser!.id as String, widget.savedMovie.id);
        Helpers.showCustomAlert(context, alerttext: "Movie Saved Succefully" , success: true);
      } else {
        await removeMovieFromSavedList(
            Session.currentUser!.id as String, widget.savedMovie.id);
        Helpers.showCustomAlert(context, alerttext: "Movie removed " , success: false);
      }
      widget.isSelected();
    } catch (e) {
      setState(() {
        isSelected = !isSelected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsPage(
                    movie: widget.savedMovie,
                    SavedState: isSelected,
                    isSelected: _isSelected)));
      },
      child: Container(
        height: widget.screenHeight / 6,
        width: widget.screenWidth,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            // Movie Poster Container
            Container(
              width: widget.screenWidth / 3,
              height: widget.screenHeight / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(widget.savedMovie.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Movie Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Movie Name and Bookmark Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.savedMovie.movieName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: _isSelected,
                        icon: Icon(
                          isSelected ? Icons.bookmark : Icons.bookmark_border,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  // Movie Description
                  Text(
                    widget.savedMovie.aboutMovie,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
