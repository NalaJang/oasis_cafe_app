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


  bool isNewOrder = false;
  Future<bool> getOrderState() async {
    await orderStateCollection
        .where('processState', isEqualTo: 'new')
        .get().then((querySnapshot) {
          if( querySnapshot.size > 0 ) {
            print('새 주문 있음');
            isNewOrder = true;
          }
        });
    return isNewOrder;
    // await orderStateCollection
        // .where('processState', isEqualTo: 'inProcess')
        // .orderBy('orderTime', descending: false)
    //     .get()
    //     .then((querySnapshot) {
    //       for( var docSnapshot in querySnapshot.docs ) {
    //         print('${docSnapshot.id}');
    //       }
    // });
  }
}