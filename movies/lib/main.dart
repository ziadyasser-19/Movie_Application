import 'package:Movie_App/view/splashscreen.dart';
import 'package:flutter/material.dart';


void main() {
  
  runApp(MaterialApp(
    home: SplashScreen(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: const Color.fromARGB(255, 16, 22, 41),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
    ),
  ));
}

