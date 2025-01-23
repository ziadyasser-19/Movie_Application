// ignore_for_file: use_build_context_synchronously

import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/widgets/customtextfield.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/loginhelpers.dart';
import 'package:flutter/material.dart';

class Signuppage extends StatefulWidget {
  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  // Form attributes ===================================
  var userName = TextEditingController();
  var userpassword = TextEditingController();
  var userConfirmpassword = TextEditingController();
  var signupformKey = GlobalKey<FormState>();

  //=============================================================

  @override
  Widget build(BuildContext context) {
    void returnLoginPage() {
      Navigator.pop(context);
    }

    Future<void> checkSignUp() async {
      if (signupformKey.currentState!.validate() &&
          (userpassword.text == userConfirmpassword.text)) {
        try {
          await signupUser(userName.text, userpassword.text);
          returnLoginPage();
          Helpers.showCustomAlert(context, alerttext: "Succefully Registerd :)" , success: true);
          setState(() {
          userName.clear();
          userpassword.clear();
        });
        } catch (e) {
          if (e.toString().contains('Username already exists')) {
            Helpers.showCustomAlert(context, alerttext: e.toString() , success: false);
          } else {
            Helpers.showCustomAlert(context,
                alerttext: "Signup failed: ${e.toString()}" ,success: false);
          }
        }
      } else {
        Helpers.showCustomAlert(context, alerttext: "Passwords do not match!" , success: false);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: signupformKey,
          child: Center(
            child: Container(
              height: 500,
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Settings.Navigationbarcolor,
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 91, 86, 109).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(
                        0, 5), // Horizontal and vertical shadow offset
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  LoginHelpers.textAndIcon(
                      text: "Sign Up",
                      icon: const Icon(
                        Icons.inventory_sharp,
                        color: Colors.white,
                      )),
                  //==========================================================
                  LoginHelpers.horizontalLineCustomized(),
                  //======================================================================
                  //the 2 text field
                  Customtextfield(
                    screenWidth: 200,
                      controller: userName,
                      errorText: "Please enter Your Name",
                      hintText: "Enter Your name",
                      suffixIcon: Icon(
                        Icons.person,
                        color: Colors.white.withOpacity(0.9),
                        size: 18,
                      ),
                      ObsecureText: false,
                      upperText: "Name"),
                  //===================================================
                  const SizedBox(
                    height: 10,
                  ),
                  //====================================================
                  Customtextfield(
                    screenWidth: 200,
                    controller: userpassword,
                    errorText: "Please enter your Password",
                    hintText: "Enter Your Password",
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                    ObsecureText: true,
                    upperText: "Password",
                    emergancyIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                  ),
                  //==============================================================
                  const SizedBox(
                    height: 10,
                  ),
                  //====================================================
                  Customtextfield(
                    screenWidth: 200,
                    controller: userConfirmpassword,
                    errorText: "Enter your Password",
                    hintText: "Confirm Your Password",
                    suffixIcon: Icon(
                      Icons.visibility_off,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                    ObsecureText: true,
                    upperText: "Confirm Password",
                    emergancyIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white.withOpacity(0.9),
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  LoginHelpers.loginButton(onPressedFunction: checkSignUp , text: "Sign up"),
                  //================================================================
                  LoginHelpers.customLink(
                      firstSentence: "Do you have an account",
                      secondLink: 'Login !',
                      onPressedFunction: () {
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
