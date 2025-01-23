import 'package:flutter/material.dart';

class SuggestionMovieComponent extends StatelessWidget {
  final ImageProvider movieImage;
  final String movieEpisodeName;
  final String movieDescription;
  final double screenHeight;
  final double screenWidth;

  const SuggestionMovieComponent({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.movieDescription,
    required this.movieImage,
    required this.movieEpisodeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight / 6,
      width: screenWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          
          Container(
            width: screenWidth / 3,
            height: screenHeight / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: movieImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10), 
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        movieEpisodeName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis, 
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                // Movie Description
                Text(
                  movieDescription,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2, 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
