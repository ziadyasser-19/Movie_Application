import 'package:Movie_App/Server/session.dart';
import 'package:Movie_App/backend/backend.dart';
import 'package:Movie_App/settings/const.dart';
import 'package:Movie_App/view/home.dart';
import 'package:Movie_App/view/signuppage.dart';
import 'package:Movie_App/widgets/customtextfield.dart';
import 'package:Movie_App/widgets/helpers.dart';
import 'package:Movie_App/widgets/loginhelpers.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool encryptPass = true;

  var userName = TextEditingController();

  var userpassword = TextEditingController();

  var formKey = GlobalKey<FormState>();

  _submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        final username = userName.text;
        final password = userpassword.text;

        final user = await loginUser(username, password);

        Session.setCurrentUser(user);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));

        Helpers.showCustomAlert(context,
            alerttext: "Logged Successfully", success: true);

        setState(() {
          userName.clear();
          userpassword.clear();
        });
      } catch (e) {
        Helpers.showCustomAlert(context,
            alerttext: "Login Failed: Check Pass and Name again !",
            success: false);
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Container(
              height: 400,
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
                      text: "Login",
                      icon: const Icon(
                        Icons.videocam,
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
                    height: 50,
                  ),
                  LoginHelpers.loginButton(
                      onPressedFunction: _submitForm, text: "Login"),
                  //================================================================
                  LoginHelpers.customLink(
                      firstSentence: "Don't have an account",
                      secondLink: 'Sign up!',
                      onPressedFunction: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Signuppage()));
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
