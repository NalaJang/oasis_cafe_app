import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomerServiceProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  late CollectionReference openingHoursCollection;
  late DocumentReference phoneNumberDocument;


  CustomerServiceProvider() {
    openingHoursCollection = db.collection('aboutUs').doc('openingHoursDoc').collection('openingHours');
    phoneNumberDocument = db.collection('aboutUs').doc('phoneNumberDoc');
  }


  // 매장 전화번호 가져오기
  Future<void> getPhoneNumber() async {
    await phoneNumberDocument.get().then((snapshot) {
      print('snapshot > ${snapshot.data()}');
    });
  }
}