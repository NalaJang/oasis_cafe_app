import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../strings/strings_en.dart';

class OrderStateProvider with ChangeNotifier {

  final db = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  late CollectionReference orderStateCollection;


  OrderStateProvider() {
    orderStateCollection = db.collection(Strings.collection_user)
                              .doc(userUid)
                              .collection(Strings.collection_userOrder);
  }

}