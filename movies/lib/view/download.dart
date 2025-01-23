import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/widgets/downloadmoviecomponent.dart';
import 'package:Movie_App/widgets/listdownloaded.dart';
import 'package:Movie_App/widgets/underaboutbutton.dart';
import 'package:flutter/material.dart';

class DownloadMovies extends StatefulWidget {
  const DownloadMovies({super.key});

  @override
  State<DownloadMovies> createState() => _DownloadMoviesState();
}

class _DownloadMoviesState extends State<DownloadMovies> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Scaffold(
//============================================APP Bar==================================================
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Download" , style: Settings.menuText,),
          backgroundColor: Settings.BackGroundcolor,
        ),
//=================================================================================
        //================================Body Start==================================
        body: 
        SingleChildScrollView(
          
          child: Column(
            children: [
              SizedBox(height: screenHeight/30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  //===================================Under Buttons for choosing =====================================
                  UnderAboutButton(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth+100,
                    ButtonText: "Downloaded",
                    isSelected: selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                  ),
                  UnderAboutButton(
                    screenHeight: screenHeight,
                    screenWidth: screenWidth + 50,
                    ButtonText: "Downloading",
                    isSelected: selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                  ),
                ],
              ),
//=============================================================================
            const SizedBox(height: 20,),
//=============================================================================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  height: screenHeight /2 + 60,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    color: Settings.Navigationbarcolor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //===================================Child based on button choosing ============================
                  child: selectedIndex == 0 ? ListdownloadedMovies(downloaded: DownloadMovieComponent(
                                      screenHeight: screenHeight,
                                      screenWidth: screenWidth,
                                      movieImage: const AssetImage(
                                          'assets/images/Movie1.jpg'),
                                      movieEpisodeName: "HomeAlone S1.2",
                                      movieDescription: "Horror - Action"),)
                          : ListdownloadedMovies(
                              downloaded: DownloadMovieComponent(
                                  screenHeight: screenHeight,
                                  screenWidth: screenWidth,
                                  movieImage: const AssetImage(
                                      'assets/images/squidgame2.png'),
                                  movieEpisodeName: "squidgame2",
                                  movieDescription: "Action - Adventure"))),
                )
            ],
          ),
        )
        ),
    );
  }
}