import 'package:Movie_App/settings/const.dart';
import 'package:flutter/material.dart';

class Profilehelpers {
  static topProfile(context,
      {required double screenHeight,
      required double screenWidth,
      required userName}) {
    return Container(
      height: screenHeight / 9,
      width: screenWidth,
      decoration: BoxDecoration(
          color: Settings.Navigationbarcolor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
                  BoxShadow(
                    blurRadius: 5 , 
                    color:Color.fromARGB(255, 50, 44, 44),
                    spreadRadius: 0.1 ,
                  )
              ]
          ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: const DecorationImage(
                  image: AssetImage("assets/images/profile.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5 , 
                    color:Color.fromARGB(255, 50, 44, 44),
                    spreadRadius: 0.1 ,
                  )
              ]
              ),
            ),
          ),
          Text(
            userName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }

  static profileButtons(context,
      {required double screenHeight,
      required double screenWidth,
      required String buttontext,
      required Icon icon,
      required Color textcolor,
      required VoidCallback function
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
          height: screenHeight / 20,
          width: screenWidth,
          decoration: BoxDecoration(
              color: Settings.Navigationbarcolor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                  BoxShadow(
                    blurRadius: 5 , 
                    color: Color.fromARGB(255, 50, 44, 44),
                    spreadRadius: 0.1 ,
                  )
              ]
              ),
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                buttontext,
                style: TextStyle(
                    color: textcolor, fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              icon,
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
