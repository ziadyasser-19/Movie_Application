// ignore_for_file: must_be_immutable, camel_case_types

import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  Color color;
  String buttonText;
  Icon icon;

  BigButton({
    super.key,
    required this.icon,
    required this.buttonText,
    required this.color,
    required this.screenHeight,
    required this.screenWidth,
  });

  final double screenHeight;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your onTap functionality here
      },
      child: Container(
        height: screenHeight / 17,
        width: screenWidth / 3 + 17,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 8), // Add spacing between icon and text
              Text(
                buttonText,
                style: Settings.menuText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
