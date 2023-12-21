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


  // 준비 중인 메뉴(inProcess) 중 현재 사용자의 메뉴의 순서를 가져온다.
  // 'user' -> '현재 사용자 uid' -> 'user_order' -> inProcess 상태인 doc id 와
  // 'user_order_new' -> inProcess 상태의 'orderUid' 와 비교
  Future<int> getMyOrderNumber(String id) async {
    var orderNumber = 0;
    await db.collection('user_order_new')
            .where('processState', isEqualTo: 'inProcess')
            // .orderBy('processState')
            .orderBy('orderTime', descending: false)
            .get()
            .then((res) {
              for( var i = 0; i < res.size; i++ ) {
                var getId = res.docs[i].id;
                var orderUid = res.docs[i]['orderUid'];

                if( id == orderUid ) {
                  orderNumber = i + 1;
                  return orderNumber;
                }
              }
    });

    return orderNumber;
  }
}