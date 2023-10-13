import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app/model/model_transactionHistory.dart';

import '../strings/strings_en.dart';

class TransactionHistoryProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  List<TransactionHistoryModel> historyList = [];
  bool isOrdered = true;


  // 주문하기
  Future<bool> orderItems(
      String userUid,
      String year,
      String month,
      String day,
      String hour,
      String time,
      int quantity,
      String itemName,
      String itemPrice,
      double totalPrice,
      String drinkSize,
      String cup,
      String hotOrIced,
      int espressoOption,
      String syrupOption,
      String whippedCreamOption,
      String iceOption
      ) async {

    // user 정보에 저장되는 데이터베이스 경로
    await db.collection(Strings.collection_user).doc(userUid)
        .collection(Strings.collection_userOrder).doc(year)
        .collection(month).doc(day)
        .collection(hour).doc()
        .set(
        {
          'orderTime' : time,
          'userUid' : userUid,
          'quantity' : quantity,
          'itemName' : itemName,
          'itemPrice' : itemPrice,
          'totalPrice' : totalPrice,
          'drinkSize' : drinkSize,
          'cup' : cup,
          'hotOrIced' : hotOrIced,
          'espressoOption' : espressoOption,
          'syrupOption' : syrupOption,
          'whippedCreamOption' : whippedCreamOption,
          'iceOption' : iceOption,
        }
    )
    .onError((error, stackTrace) => {
      print('order error >> $error'),
      isOrdered = false
    });


    // 매장에서 볼 데이터베이스 경로
    await db.collection('user_order').doc(year)
        .collection(month).doc(day)
        .collection(hour).doc()
        .set(
        {
          'orderTime' : time,
          'userUid' : userUid,
          'quantity' : quantity,
          'itemName' : itemName,
          'itemPrice' : itemPrice,
          'totalPrice' : totalPrice,
          'drinkSize' : drinkSize,
          'cup' : cup,
          'hotOrIced' : hotOrIced,
          'espressoOption' : espressoOption,
          'syrupOption' : syrupOption,
          'whippedCreamOption' : whippedCreamOption,
          'iceOption' : iceOption
        }
    ).onError((error, stackTrace) => {
      print('order error >> $error'),
      isOrdered = false
    });

    print('isOrdered >>> ${isOrdered}');
    return isOrdered;
  }


  // 1개월 주문 내역 가져오기
  Future<void> getOrderHistoryForOneMonth(int startMonth, int startDay, int theLastDayOfStartMonth,
                              int lastMonth, int lastDay) async {

    if( startMonth != lastMonth ) {
      // for( var i = startDay; i <= theLastDayOfStartMonth; i++ ) {
      //   print('i = $i');
      //
      //   db.collection('user_order').doc(userUid)
      //       .collection('2023').doc(startMonth.toString())
      //       .collection(i.toString())
      //       .get().then(
      //         (querySnapshot) {
      //       for (var docSnapshot in querySnapshot.docs) {
      //         print('day ==> $i, ${docSnapshot.id} => ${docSnapshot.data()}');
      //       }
      //     },
      //     onError: (e) => print("Error completing: $e"),
      //   );
      // }

      for( var i = 1; i <= lastDay; i++ ) {

        print('day = $i');

        for( var j = 1; j < 24; j++ ) {

          historyList = await db.collection('user').doc(userUid).collection('user_order').doc('2023')
              .collection(lastMonth.toString()).doc(i.toString())
              .collection(j.toString())
              .get().then(
                (querySnapshot) {
                  return querySnapshot.docs.map((docSnapshot) {
                    return TransactionHistoryModel.getSnapshotDataFromUserOrder(docSnapshot);
                  }).toList();
                  // for (var docSnapshot in querySnapshot.docs) {
                  //   print('data time ==> $j, ${docSnapshot.id} => ${docSnapshot.data()}');
                  //   TransactionHistoryModel.getSnapshotDataFromUserOrder(docSnapshot);
                  // }

            },
            onError: (e) => print("Error completing: $e"),
          );
        }
      }
    }

  }

  Future<void> getOrderHistory(String userUid, String year, String month, String day) async {
    // await db.collection(Strings.collection_user).doc(userUid)
    //     .collection('user_order').doc(year)
    //     .collection(month).doc(day)
    //     .get()
    //     .then((DocumentSnapshot snapshot) {
    //       final data = snapshot.data() as Map<String, dynamic>;
    //       print('data >. $data');
    // });

    // await db.collection('user_order').doc(userUid)
    //     .collection(year).doc(month)
    //     .collection(day)
    //     .get().then(
    //       (querySnapshot) {
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('day ==> $day, ${docSnapshot.id} => ${docSnapshot.data()}');
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );

    historyList = await db.collection('user_order').doc(userUid)
                          .collection(year).doc(month)
                          .collection(day)
                          .get()
                          .then((querySnapshot) {
                            return querySnapshot.docs.map((document) {
                              return TransactionHistoryModel.getSnapshotDataFromUserOrder(document);
                            }).toList();
                          });
    notifyListeners();
  }
}