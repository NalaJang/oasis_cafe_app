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
        // return AboutUsModel.getOpeningHours(document);
      }).toList();
    });
    notifyListeners();
  }

  Future<void> getPhoneNumber() async {
   // await phoneNumberReference.get().then((DocumentSnapshot document) {
   //    // return AboutUsModel.getOpeningHours(document);
   //    if( document.exists ) {
   //      return AboutUsModel.getPhoneNumber(document);
   //    }
   //  });
    await db.collection('aboutUs').get().then((QuerySnapshot results) {
     return results.docs.map((DocumentSnapshot document) {
       print('${document.data()}');
       storeInfo.add(AboutUsModel.getPhoneNumber(document));
     }).toList();
   });
    notifyListeners();
  }

  Future<void> fetchStoreInfo() async {
    await getOpeningHours();
    await getPhoneNumber();
    for( var i = 0; i < storeInfo.length; i++ ) {
      print('data > ${storeInfo[i].number3}');
    }
  }
}