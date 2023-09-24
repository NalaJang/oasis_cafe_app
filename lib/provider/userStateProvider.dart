import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserStateProvider with ChangeNotifier {
  final _authentication = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  // final CollectionReference itemCollectionReference = FirebaseFirestore.instance.collection('user');

  bool isLogged = false;
  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userDateOfBirth = '';
  String userMobileNumber = '';

  Future<bool> signIn(String email, String password) async {
    final newUser = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (newUser.user != null) {
      userUid = newUser.user!.uid;

      await FirebaseFirestore.instance.collection('user')
          .doc(userUid)
          .get()
          .then((value) =>
      {
        userName = value.data()!['userName'],
        userEmail = value.data()!['userEmail'],
        userDateOfBirth = value.data()!['userDateOfBirth'],
        userMobileNumber = value.data()!['userMobileNumber']
      });
    }

    if (newUser.user != null) {
      isLogged = true;
    }

    return isLogged;
  }

  // 장바구니에 선택한 음료 담기
  Future<void> addItemsToCart(
      String drinkSize,
      String cup,
      String hotOrIced,
      String selectedItem,
      int espressoOption,
      String syrupOption,
      String whippedCreamOption,
      String iceOption
      ) async {
    await db.collection('user').doc(userUid).collection('user_cart').add(
      {
        'drinkSize' : drinkSize,
        'cup' : cup,
        'hotOrIced' : hotOrIced,
        'selectedItem' : selectedItem,
        'espressoOption' : espressoOption,
        'syrupOption' : syrupOption,
        'whippedCreamOption' : whippedCreamOption,
        'iceOption' : iceOption
      }
    );
  }
}