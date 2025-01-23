// ignore_for_file: must_be_immutable

import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';


class UnderAboutButton extends StatefulWidget {
  String ButtonText;
  UnderAboutButton({
    super.key,
    required this.ButtonText,
    required this.screenHeight,
    required this.screenWidth,
    this.isSelected = false,
    required this.onPressed,
  });

  final double screenHeight;
  final double screenWidth;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  State<UnderAboutButton> createState() => _UnderAboutButtonState();
}

class _UnderAboutButtonState extends State<UnderAboutButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: widget.screenHeight / 15,
        width: widget.screenWidth / 3,
        decoration: BoxDecoration(
          color: Settings.Navigationbarcolor,
          border: Border(
            bottom: BorderSide(
              color: widget.isSelected ? Settings.binkthemecolor : Colors.white,
              width: 3,
            ),
          ),
        ),
        child: Center(
          child: Text(
            widget.ButtonText,
            style: TextStyle(
              color: widget.isSelected ? Settings.binkthemecolor : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
