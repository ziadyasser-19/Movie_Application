import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';


class LoginHelpers {
  static Padding textAndIcon({required String text ,required Icon icon}) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          icon
        ],
      ),
    );
  }

  static Padding horizontalLineCustomized() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Divider(
        thickness: 1,
        height: 2,
        color: Colors.white,
      ),
    );
  }

  static loginButton({required VoidCallback onPressedFunction , required String text}) {
    return Center(
      child: GestureDetector(
        onTap: onPressedFunction,
        child: Container(
          height: 30,
          width: 120,
          decoration: BoxDecoration(
            color: Settings.BackGroundcolor,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 91, 86, 109).withOpacity(0.3),
                blurRadius: 10,
                offset:
                    const Offset(0, 5), // Horizontal and vertical shadow offset
                spreadRadius: 2,
              ),
            ],
          ),
          child:  Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }

  static customLink({required String firstSentence , required String secondLink , required VoidCallback onPressedFunction}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstSentence,
            style: const TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
              onTap: onPressedFunction,
              child: Text(
                secondLink,
                // ignore: prefer_const_constructors
                style: TextStyle(color: Colors.deepPurple, fontSize: 12),
              ))
        ],
      ),
    );
  }
}
