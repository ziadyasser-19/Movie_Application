import 'dart:math'; // Import for Random class
import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/models/movie.dart';
import 'package:Movie_App/view/download.dart';
import 'package:Movie_App/view/profile.dart';
import 'package:Movie_App/view/savedmovies.dart';
import 'package:Movie_App/view/search.dart';
import 'package:Movie_App/widgets/bottomnavigationbar.dart';
import 'package:Movie_App/widgets/categoriesbutton.dart';
import 'package:Movie_App/widgets/imagehomesliders.dart';
import 'package:Movie_App/widgets/listmoviecomponent.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<List<Movie>> futurePopularMovies;
  late Future<List<Movie>> futureLatestMovies;

  String? userId = Session.currentUser!.id;

  List<String> _images = [];

  // For Category Selection
  int selectedCategory = 0;
  final List<String> categories = [
    'All',
    'Action',
    'Comedy',
    'Horror',
    'Romantic',
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchMoviesForCategory(selectedCategory);
  }

  List<String> _getRandomImageUrls(List<Movie> movies, int count) {
    final random = Random();

    List<Movie> shuffledMovies = List.from(movies)..shuffle(random);

    return shuffledMovies.take(count).map((movie) => movie.imageURL).toList();
  }

  void RefreshPage() {
    _fetchMoviesForCategory(selectedCategory);
    setState(() {});
  }

  void _fetchMoviesForCategory(int categoryIndex) {
    setState(() {
      selectedCategory = categoryIndex;
      switch (categoryIndex) {
        case 0:
          futurePopularMovies = fetchMovies(userId!);
          futureLatestMovies = fetchMovies(userId!);
          break;
        case 1:
          futurePopularMovies = fetchActionMovies(userId!);
          futureLatestMovies = fetchActionMovies(userId!);
          break;
        case 2:
          futurePopularMovies = fetchComedyMovies(userId!);
          futureLatestMovies = fetchComedyMovies(userId!);
          break;
        case 3:
          futurePopularMovies = fetchHorrorMovies(userId!);
          futureLatestMovies = fetchHorrorMovies(userId!);
          break;
        case 4:
          futurePopularMovies = fetchRomanticMovies(userId!);
          futureLatestMovies = fetchRomanticMovies(userId!);
          break;
        default:
          futurePopularMovies = fetchMovies(userId!);
          futureLatestMovies = fetchMovies(userId!);
          break;
      }

      // Update the slider images with popular movies
      futurePopularMovies.then((movies) {
        setState(() {
          _images = _getRandomImageUrls(movies, 5);
        });
      }).catchError((error) {
        print("Error fetching movies: $error");
      });
    });
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(onTap: onItemTapped),
      body: IndexedStack(
        index: _selectedIndex,
        children: <Widget>[
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ImageSlider(
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  images: _images,
                ),
              ),
              SliverToBoxAdapter(
                child: CategoriesButton(
                  categories: categories,
                  onCategorySelected: (index) {
                    _fetchMoviesForCategory(index);
                  },
                ),
              ),
              // Popular Movies
              SliverToBoxAdapter(
                child: FutureBuilder<List<Movie>>(
                  future: futurePopularMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    } else {
                      return ListMovieComponent(
                        movies: snapshot.data!,
                        textAboveList: "Most Popular",
                      );
                    }
                  },
                ),
              ),
              // Latest Movies
              SliverToBoxAdapter(
                child: FutureBuilder<List<Movie>>(
                  future: futureLatestMovies,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No movies found.'));
                    } else {
                      return ListMovieComponent(
                        movies: snapshot.data!,
                        textAboveList: "Latest Movies",
                      );
                    }
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: screenHeight / 40),
              ),
            ],
          ),
          const SearchMovie(),
          Savedmovies(),
          const DownloadMovies(),
          MyProfile(user: Session.currentUser!,),
        ],
      ),
    );
  }
}
