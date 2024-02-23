import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:permission_handler/permission_handler.dart';

import '../strings/strings_en.dart';

class UserStateProvider with ChangeNotifier {
  final _authentication = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = const FlutterSecureStorage();
  User? _user;
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


  // 로그인 유무를 판단하기 위해 user 정보를 가져온다.
  // User? getUser() {
  //   return _user;
  // }
  //
  // void setUser(var user) {
  //   _user = user;
  //   notifyListeners();
  // }


  // 회원가입
  Future<bool> signUp(String email, String password, String name, String mobileNumber) async {
    final newUser = await _authentication.createUserWithEmailAndPassword(
        email: email, password: password
    );

    if( newUser.user != null ) {
      userUid = newUser.user!.uid;

      await FirebaseFirestore.instance
          .collection(Strings.collection_user)
          .doc(userUid)
          .set({
        // 데이터의 형식은 항상 map 의 형태
        'signUpTime' : DateTime.now(),
        'userEmail' : email,
        'userPassword' : password,
        'userName' : name,
        'userDateOfBirth' : '',
        'userMobileNumber' : mobileNumber,
        'notification' : false,
        'shakeToPay' : false
      });

      return true;
    }
    return false;
  }

  // 로그인
  Future<bool> signIn(String email, String password) async {
    final newUser = await _authentication.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    if (newUser.user != null) {
      // setUser(newUser.user);
      userUid = newUser.user!.uid;

      // 사용자 정보 가져오기
      await getUserInfo(userUid);

      // 자동 로그인을 위한 사용자 정보 저장
      await storage.write(key: userUid, value: 'STATUS_LOGIN');

      isLogged = true;
    }

    return isLogged;
  }


  // 로그아웃
  Future<bool> signOut() async {
    try {
      await _authentication.signOut();
      // setUser(null);

      Map<String, String> allValues = await storage.readAll();
      if( allValues != null ) {
        allValues.forEach((key, value) async {

          if( value == 'STATUS_LOGIN' ) {
            await storage.write(key: userUid, value: 'STATUS_LOGOUT');

            // 로그아웃 후 메인 화면으로 가도 과거의(?) userUid 가 남아있어서 화면 초기화가 되지 않아서 추가.
            userUid = '';
          }

        });
      }
      notifyListeners();

      return true;

    } catch(e) {
      print(e.toString());
    }
    return false;
  }


  Future<void> getStorageInfo() async {
    // Read all values
    Map<String, String> allValues = await storage.readAll();

    if( allValues != null ) {
      allValues.forEach((key, value) {

        if( value == 'STATUS_LOGIN' ) {
          userUid = key;
          getUserInfo(userUid);

        }
      });
    }

    // 해당 메소드를 호출함으로써 로그아웃 했을 때 화면 UI 가 재로딩된다.
    notifyListeners();
  }


  // 로그인 사용자 정보 가져오기
  Future<void> getUserInfo(String userUid) async {
    // 사용자 휴대폰에서 앱의 알람 상태를 가져온다.
    await getNotificationPermissionState();
    await db.collection(Strings.collection_user)
        .doc(userUid)
        .get()
        .then((value) =>
    {
      userName = value.data()!['userName'],
      userEmail = value.data()!['userEmail'],
      userDateOfBirth = value.data()!['userDateOfBirth'],
      userMobileNumber = value.data()!['userMobileNumber'],
      // notification = value.data()!['notification'],
      shakeToPay = value.data()!['shakeToPay']
    });
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

    notifyListeners();
    return isUpdated;
  }

  // 사용자 휴대폰에서 앱의 알람 상태를 가져온다.
  getNotificationPermissionState() async {
    var status = await Permission.notification.status;
    if( status.isGranted ) {
      notification = true;
    } else if( status.isDenied || status.isPermanentlyDenied ) {
      notification = false;
    }
  }

  Future<void> updatePreferences(String menuName, bool selectedSwitchButton) async {
    // if( menuName == 'Notification' ) {
    //   await userInfo.doc(userUid).update({
    //     'notification' : selectedSwitchButton
    //   });
    //
    // } else
    if( menuName == 'Shake to pay' ) {
      await userInfo.doc(userUid).update({
        'shakeToPay' : selectedSwitchButton
      });
    } else {
      await userInfo.doc(userUid).update({
        'notification' : selectedSwitchButton
      });
    }
    notifyListeners();
  }

  // 계정 삭제
  Future<bool> deleteAccount() async {
    try {
      await _authentication.currentUser?.delete();
      await userInfo.doc(userUid).delete();
      await storage.delete(key: userUid);
      print('deleteAccount');
      return true;

    } catch(e) {
      print(e.toString());
    }
    return false;
  }
}