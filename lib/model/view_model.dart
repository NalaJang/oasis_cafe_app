import 'package:firebase_auth/firebase_auth.dart';

class ViewModel {

  User? currentUser;

  void setCurrentUser(FirebaseAuth auth) {
    try {
      final user = auth.currentUser;
      if( user != null ) {
        currentUser = user;
        print('currentUser 불러오기 : $currentUser');
      }

    } catch(e) {
      print(e);
    }
  }
}