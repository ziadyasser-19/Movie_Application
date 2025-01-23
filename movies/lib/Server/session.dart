import 'package:Movie_App/models/Users.dart';

class Session {
  static User? currentUser;

  static void setCurrentUser(User currentuser) {
    Session.currentUser = currentuser;
  }

  static void nullerCurrentUser() {
    Session.currentUser = null;
  }
}
