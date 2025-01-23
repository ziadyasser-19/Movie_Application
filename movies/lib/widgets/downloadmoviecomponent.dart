import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class DownloadMovieComponent extends StatelessWidget {
  final ImageProvider movieImage;
  final String movieEpisodeName;
  final String movieDescription;
  final double screenHeight;
  final double screenWidth;

  const DownloadMovieComponent({
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
            width: screenWidth / 3 - 20,
            height: screenHeight / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: movieImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        movieEpisodeName.length > 18
                            ? movieEpisodeName.substring(0, 18) +
                                '\n' +
                                movieEpisodeName.substring(18)
                            : movieEpisodeName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: movieEpisodeName.length < 20
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
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
                const SizedBox(
                  height: 12,
                ),
                const Row(
                  children: [
                    Text("120 Mb ", style: Settings.download_text),
                    Text(
                      "|| ",
                      style: Settings.download_text,
                    ),
                    Text(
                      " 15 Gb",
                      style: Settings.download_text,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
