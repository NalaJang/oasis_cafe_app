import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../strings/strings_en.dart';

class UserStateProvider with ChangeNotifier {
  final _authentication = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  CollectionReference userInfo = FirebaseFirestore.instance.collection('user');

  bool isLogged = false;
  bool isUpdated = false;
  String userUid = '';
  String userName = '';
  String userEmail = '';
  String userDateOfBirth = '';
  String userMobileNumber = '';
  bool notification = false;
  bool shakeToPay = false;
  List<String> data = [Strings.termsOfUseAgreed, Strings.privacyPolicyAgreed, Strings.marketingConsentAgreed];

  // 선택된 약관 동의
  void addCheck(String checkedItem) {
    var index = data.indexWhere((element) => element.toString() == data.toString());
    if( index == -1 ) {
      data.add(checkedItem);
      notifyListeners();
    }
  }

  // 선택 해제된 약관 동의
  void removeCheck(String checkedItem) {
    data.removeWhere((element) => element.toString() == checkedItem.toString());
    notifyListeners();
  }

  // 로그인
  Future<bool> signIn(String email, String password) async {
    final newUser = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (newUser.user != null) {
      userUid = newUser.user!.uid;

      await db.collection(Strings.collection_user)
          .doc(userUid)
          .get()
          .then((value) =>
      {
        userName = value.data()!['userName'],
        userEmail = value.data()!['userEmail'],
        userDateOfBirth = value.data()!['userDateOfBirth'],
        userMobileNumber = value.data()!['userMobileNumber'],
        notification = value.data()!['notification'],
        shakeToPay = value.data()!['shakeToPay']
      });
    }

    if (newUser.user != null) {
      isLogged = true;
    }

    return isLogged;
  }

  // 로그아웃
  Future<void> signOut() async{
    try {
      await _authentication.signOut();
      print('signOut');
    } catch(e) {
      print(e.toString());
    }
  }

  // 사용자 정보 수정
  Future<bool> updateUserInfo(String name, String dateOfBirth, String mobileNumber) async {
    await userInfo.doc(userUid).update({
      'userName' : name,
      'userDateOfBirth' : dateOfBirth,
      'userMobileNumber' : mobileNumber,
    });

    await db.collection(Strings.collection_user)
        .doc(userUid)
        .get()
        .then((value) =>
    {
      userName = value.data()!['userName'],
      userDateOfBirth = value.data()!['userDateOfBirth'],
      userMobileNumber = value.data()!['userMobileNumber'],

      isUpdated = true
    },
    onError: (e) => isUpdated = false
    );

    return isUpdated;
  }

  // update 메소드를 나누는 게 나은지, 하나의 메소드 안에서 if 문으로 나누는 게 나은지..
  Future<void> updatePreferences(String menuName, bool selectedSwitchButton) async {
    if( menuName == 'Notification' ) {
      await userInfo.doc(userUid).update({
        'notification' : selectedSwitchButton
      });

    } else if( menuName == 'Shake To Pay' ) {
      await userInfo.doc(userUid).update({
        'shakeToPay' : selectedSwitchButton
      });
    }

  }

  // 계정 삭제
  // todo: 삭제 결과가 db 에 반영되기까지 약간의 시간이 걸리는 부분에 대한 대안(?) 필요
  Future<void> deleteAccount() async {
    try {
      await _authentication.currentUser?.delete();
      await userInfo.doc(userUid).delete();
      print('deleteAccount');
    } catch(e) {
      print(e.toString());
    }
  }
}