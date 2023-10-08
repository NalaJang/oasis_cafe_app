import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app/model/model_transactionHistory.dart';

import '../strings/strings.dart';

class TransactionHistoryProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  List<TransactionHistoryModel> historyList = [];

  // 주문하기
  Future<void> orderItems(
      String userUid,
      String year,
      String month,
      String day,
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
    await db.collection('user_order').doc(userUid)
        .collection(year).doc(month)
        .collection(day).doc(time)
        .set(
        {
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
    );
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