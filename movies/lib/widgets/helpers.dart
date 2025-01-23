import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class Helpers {
  static menuIcon(String menutext, Icon icon,
      {Color borderColor = Colors.transparent}) {
    return PopupMenuItem<String>(
        value: menutext,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: borderColor, width: 1),
              bottom: BorderSide(color: borderColor, width: 1),
              left: BorderSide.none,
              right: BorderSide.none,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(menutext, style: Settings.menuText), icon],
          ),
        ));
  }

  static noSavedFound(double screenHeight, double screenWidth) {
    return Center(
      child: Container(
        height: screenHeight / 4,
        width: screenWidth / 2,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/images/noSaved.png"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 208, 195, 195).withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 15,
              spreadRadius: 4,
            ),
          ],
        ),
      ),
    );
  }

  static textBetweenMovies(
      {required String text, required double screenHeight}) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: screenHeight / 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
              child: Divider(
            thickness: 1.5,
            color: Colors.white,
          )),
          Expanded(
              child: SizedBox(
            height: screenHeight / 70,
          )),
          Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight / 35,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: SizedBox(
            height: screenHeight / 60,
          )),
          const Expanded(
              child: Divider(
            thickness: 1.5,
            color: Colors.white,
          )),
        ],
      ),
    );
  }

  static Widget detailedMovieButton({
    required Function onPressed,
    required Icon icon,
    required BuildContext context,
  }) {
    return IconButton(
      onPressed: () => onPressed(),
      icon: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 0, 0, 0),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 243, 236, 236).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8),
        child: icon,
      ),
    );
  }

  static void showCustomAlert(BuildContext context,
      {required String alerttext , required bool success}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Center(
          child: Container(
            width: 250,
            height: 150,
            decoration: BoxDecoration(
              color: Settings.Navigationbarcolor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                success? const Icon(Icons.check_circle, color: Colors.green, size: 40) :Icon(Icons.close, color: Colors.red, size: 40) ,
                const SizedBox(height: 10),
                Text(
                  alerttext,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

 
}
