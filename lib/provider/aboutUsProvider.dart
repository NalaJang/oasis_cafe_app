import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../model/model_aboutUs.dart';

class AboutUsProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  late CollectionReference openingHoursCollection;
  late DocumentReference phoneNumberReference;
  List<AboutUsModel> storeInfo = [];

  AboutUsProvider() {
    openingHoursCollection = db.collection('aboutUs').doc('openingHoursDoc').collection('openingHours');
    phoneNumberReference = db.collection('aboutUs').doc('phoneNumberDoc');
  }

  Future<void> fetchStoreInfo() async {
    await openingHoursCollection.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return AboutUsModel.getOpeningHours(document);
      }).toList();
    });
    notifyListeners();
  }
}