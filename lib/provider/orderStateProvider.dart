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


  String orderState = '';
  Future<String> getOrderState() async {
    /*
    .where('processState', isEqualTo: 'new')
    .orderBy('orderTime', descending: false)
    를 같이 사용하려고 하니 'The query requires an index' 라는 에러가 떴다.
    두 가지 이상의 조건을 사용 시에는 직접 색인을 추가해 주어야 한다고 한다.
    에러 메시지와 함께 복합 색인을 생성할 수 있는 firestore 링크가 제공되었고
    링크를 통해 색인을 생성 후 실행하니까 에러 없이 진행되었다.
    */
    await orderStateCollection
        .where('processState', isEqualTo: 'new')
        .orderBy('orderTime', descending: false)
        .get().then((querySnapshot) {
          for( var docSnapshot in querySnapshot.docs ) {
            print('${docSnapshot.id}');
          }
          if( querySnapshot.size > 0 ) {
            print('새 주문 있음');
            orderState = 'new';
            return orderState;
          }
        });

    await orderStateCollection
        .where('processState', isEqualTo: 'inProcess')
        .get().then((querySnapshot) {
      if( querySnapshot.size > 0 ) {
        orderState = 'inProcess';
        return orderState;
      }
    });
    return orderState;
  }
}