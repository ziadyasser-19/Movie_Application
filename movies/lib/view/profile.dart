// ignore_for_file: must_be_immutable

import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/models/Users.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/profilehelpers.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  User user;
  MyProfile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50),
      child: Column(
        children: [
          Profilehelpers.topProfile(context,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              userName: user.username),
          const SizedBox(
            height: 20,
          ),
          Profilehelpers.profileButtons(context,
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              buttontext: "Language",
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 18,
              ),
              textcolor: Colors.white,
              function: () {}),
          Profilehelpers.profileButtons(
            context,
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            buttontext: "Log Out",
            icon: const Icon(
              Icons.door_sliding_sharp,
              color: Colors.white,
              size: 18,
            ),
            textcolor: const Color.fromARGB(255, 250, 1, 1),
            function: () {
              Session.nullerCurrentUser();
              Navigator.pop(context);
              Helpers.showCustomAlert(context,
                  alerttext: "Loged Out Succefully", success: true);
            },
          ),
        ],
      ),
    ));
  }
}
