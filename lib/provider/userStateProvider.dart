import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserStateProvider with ChangeNotifier {
  final _authentication = FirebaseAuth.instance;

  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userMobileNumber = '';

  void signIn(String email, String password) async {

    final newUser =
        await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if( newUser.user != null ) {

      userUid = newUser.user!.uid;
      var userInfo = FirebaseFirestore.instance.collection('user');

      await FirebaseFirestore.instance.collection('user')
      .doc(newUser.user!.uid)
      .get()
      .then((value) => {
        userMobileNumber = value.data()!['userMobileNumber']
      });

      print('userMobileNumber ==> $userMobileNumber');
    }

    // if( newUser.user != null ) {
    //   setState(() {
    //     showSpinner = false;
    //   });
    //
    //   Navigator.push(
    //       (context),
    //       MaterialPageRoute(builder: (context) => BottomNavi())
    //   );
    // }
  }
}