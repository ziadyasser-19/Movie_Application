// ignore_for_file: must_be_immutable, non_constant_identifier_names, sized_box_for_whitespace

import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/widgets/bigbutton.dart';
import 'package:Movie_App/widgets/episodemovies.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/similarmovielist.dart';
import 'package:Movie_App/widgets/underaboutbutton.dart';
import 'package:flutter/material.dart';

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  bool SavedState;
  VoidCallback isSelected;

  MovieDetailsPage({super.key, required this.movie, required this.SavedState , required this.isSelected});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool isExpanded = false;
  int selectedIndex = 0;
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.SavedState;
  }

//========= 3shan el state tt8yr fl 7agten hya w el movie component ===================
  void _ChangeSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.isSelected(); //=> lw ktbtha widget.isSelected kda mbtsht8lsh lazm () 
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screenHeight / 3 + 30,
              width: screenWidth,
              child: Stack(
                children: [
                  Image.network(
                    widget.movie.imageURL,
                    fit: BoxFit.cover,
                    height: screenHeight / 3 + 30,
                    width: screenWidth,
                  ),
                  Positioned(
                    top: 17,
                    right: 5,
                    child: Helpers.detailedMovieButton(
                      onPressed:_ChangeSelection ,
                      icon: Icon(
                        isSelected ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.white,
                        size: 15,
                      ),
                      context: context,
                    ),
                  ),
                  Positioned(
                    top: 17,
                    left: 5,
                    child: Helpers.detailedMovieButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_sharp,
                        color: Colors.white,
                        size: 15,
                      ),
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
            //===========================================================================

            // Movie Name
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Center(
                child: Text(
                  widget.movie.movieName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            //===========================================================================
            // Movie Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                children: [
                  Text(
                    "${widget.movie.moviedate.year} •",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 113, 101, 101),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    "${widget.movie.movietype} • ",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 113, 101, 101),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    widget.movie.movietime,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 113, 101, 101),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            //===========================================================================

            // Buttons Row
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28.0, vertical: 10),
              child: SizedBox(
                height: screenHeight / 17,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    BigButton(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      color: Settings.binkthemecolor,
                      buttonText: "Play",
                      icon: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    BigButton(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      color: Settings.Navigationbarcolor,
                      buttonText: "Download",
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //===========================================================================

            // Movie Description with Read More
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Settings.Navigationbarcolor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Settings.Navigationbarcolor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isExpanded
                                ? widget.movie.aboutMovie
                                : (widget.movie.aboutMovie.length > 100)
                                    ? "${widget.movie.aboutMovie.substring(0, 100)}..."
                                    : widget.movie.aboutMovie,
                            style: const TextStyle(color: Colors.white),
                            maxLines: isExpanded ? null : 3,
                            overflow: isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                          if (widget.movie.aboutMovie.length > 100)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? "Read Less" : "Read More",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 23, 85, 136),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //=====================================================================================

            const SizedBox(
              height: 20,
            ),

            //========================================================================
            // Row with three buttons displayed beside each other
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
              children: [
                UnderAboutButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  ButtonText: "Episode",
                  isSelected: selectedIndex == 0,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                ),
                UnderAboutButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  ButtonText: "Similar",
                  isSelected: selectedIndex == 1,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                ),
                UnderAboutButton(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  ButtonText: "About",
                  isSelected: selectedIndex == 2,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 2;
                    });
                  },
                ),
              ],
            ),

            //=====================================================
            const SizedBox(
              height: 20,
            ),
            //====================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                width: screenWidth,
                height: screenHeight / 2,
                decoration: BoxDecoration(
                  color: Settings.Navigationbarcolor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: selectedIndex == 0
                    ? Episodemovies(movie: widget.movie)
                    : selectedIndex == 1
                        ? Similarmovielist(movie: widget.movie)
                        : selectedIndex == 2
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Title
                                    const Text(
                                      "About Movie",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      height: screenHeight / 2.5 -
                                          10, // Adjust the height as needed
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 30, 30,
                                            30), // Styled background
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: SingleChildScrollView(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          widget.movie
                                              .aboutMovie, // Use the movie's description
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
              ),
            ),

            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
