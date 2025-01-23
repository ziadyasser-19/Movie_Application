import 'package:flutter/material.dart';

class Savedhelpers {
  static noMovieFound({required screenheight , required screenWidth}) {
    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          height: screenheight / 3,
          width: screenWidth / 2,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                  image: AssetImage("assets/images/oops.png"),
                  fit: BoxFit.contain)),
        ),
      ],
    );
  }
}
