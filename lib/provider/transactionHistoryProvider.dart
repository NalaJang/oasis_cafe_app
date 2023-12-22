import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app/model/model_transactionHistory.dart';

import '../strings/strings_en.dart';

class TransactionHistoryProvider with ChangeNotifier {

  late int fromSelectedYear;
  late int fromSelectedMonth;
  late int fromSelectedDay;
  late int toSelectedYear;
  late int toSelectedMonth;
  late int toSelectedDay;

  final db = FirebaseFirestore.instance;
  late CollectionReference transactionCollection;
  final userUid = FirebaseAuth.instance.currentUser!.uid;
  List<TransactionHistoryModel> historyList = [];
  List<TransactionHistoryModel> reversedHistoryList = [];
  bool isOrdered = true;
  String lastOrderUid = '';


  // 마지막 주문 uid 가져오기
  Future<void> getLastOrderId() async {

    await db.collection(Strings.collection_user)
        .doc(userUid)
        .collection(Strings.collection_userOrder)
        .orderBy('orderTime', descending: false)
        .get()
        .then((querySnapshot) {

          lastOrderUid = querySnapshot.docs.last.id;
    });
  }

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
        .collection(Strings.collection_userOrder).doc()
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
          'processState' : 'new'
        }

    ).onError((error, stackTrace) => {
      print('user order error >> $error'),
      isOrdered = false
    });


    // 마지막 주문 uid 를 가져와 매장 데이터베이스에 저장
    await getLastOrderId();

    // 매장에서 볼 데이터베이스 경로
    await db.collection('user_order_new')
        .doc()
        .set(
        {
          'orderTime' : time,
          'orderUid' : lastOrderUid,
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
          'processState' : 'new'
        }
    ).onError((error, stackTrace) => {
      print('order save error >> $error'),
      isOrdered = false
    });

    print('isOrdered >>> ${isOrdered}');
    return isOrdered;
  }

  TransactionHistoryProvider() {
    transactionCollection = db.collection(Strings.collection_user)
        .doc(userUid).collection(Strings.collection_userOrder);
        // .doc().collection('aa');
  }


  // 거래 내역 가져오기
  Future<void> getTransactionHistory() async {
    historyList = await transactionCollection
        .where('processState', isEqualTo: 'pickedUp')
        .where('orderTime', isGreaterThanOrEqualTo: '$fromSelectedYear-$fromSelectedMonth-$fromSelectedDay')
        .where('orderTime', isLessThan: '$toSelectedYear-$toSelectedMonth-${toSelectedDay +1}')
        .get()
        .then((QuerySnapshot querySnapshot) {
          return querySnapshot.docs.map((DocumentSnapshot document) {
            // 가져온 list 내역을 역순으로 출력
            reversedHistoryList = List.from(historyList.reversed);
            return TransactionHistoryModel.getSnapshotDataFromUserOrder(document);
          }).toList();
        });

    notifyListeners();
  }



  // Future<List<TransactionHistoryModel>> getTodayHistory(String year, String month, String day) async {
  //
  //   historyList.clear();
  //
  //   for( var hour = 1; hour < 24; hour++ ) {
  //     await db.collection(Strings.collection_user).doc(userUid)
  //         .collection(Strings.collection_userOrder).doc(year)
  //         .collection(month).doc(day)
  //         .collection(hour.toString())
  //         .get()
  //         .then((querySnapshot) {
  //           for (var document in querySnapshot.docs) {
  //             historyList.add(TransactionHistoryModel.getSnapshotDataFromUserOrder(document));
  //           }
  //     });
  //   }
  //   return historyList;
  // }

}