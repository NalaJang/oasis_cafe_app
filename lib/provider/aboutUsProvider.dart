import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_aboutUs.dart';

class AboutUsProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  late CollectionReference openingHoursCollection;
  late DocumentReference phoneNumberReference;
  List<AboutUsModel> openingHours = [];
  List<AboutUsModel> phoneNumbers = [];
  List<AboutUsModel> storeInfo = [];

  AboutUsProvider() {
    openingHoursCollection = db.collection('aboutUs').doc('openingHoursDoc').collection('openingHours');
    phoneNumberReference = db.collection('aboutUs').doc('phoneNumberDoc');
  }

  Future<void> getOpeningHours() async {
    storeInfo.clear();
    await openingHoursCollection.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        storeInfo.add(AboutUsModel.getOpeningHours(document));
      }).toList();
    });
    notifyListeners();
  }

  Future<void> getPhoneNumber() async {
    await db.collection('aboutUs').get().then((QuerySnapshot results) {
     return results.docs.map((DocumentSnapshot document) {
       storeInfo.add(AboutUsModel.getPhoneNumber(document));
     }).toList();
   });
    notifyListeners();
  }

  // 각 각의 db 에서 기져온 data 를 합쳐 보낸다.
  Future<void> fetchStoreInfo() async {
    await getOpeningHours();
    await getPhoneNumber();
  }
}