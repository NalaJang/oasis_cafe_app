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
          'processState' : 'new',
          'isCanceled' : false,
          'reasonOfCanceled' : ''
        }
    ).onError((error, stackTrace) => {
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
    String startDate = '$fromSelectedYear-$fromSelectedMonth-$fromSelectedDay';
    String lastDate = '$toSelectedYear-$toSelectedMonth-$toSelectedDay';

    // 내역 검색을 할 때, 날짜가 10보다 작은 경우 숫자 앞에 0을 붙여주지 않으면 검색이 안되어서 아래 코드 추가..
    // 이유는 못 찾았다.
    if( fromSelectedMonth < 10 ) {
      startDate = '$fromSelectedYear-0$fromSelectedMonth-$fromSelectedDay';
    } else if( fromSelectedDay < 10 ) {
      startDate = '$fromSelectedYear-$fromSelectedMonth-0$fromSelectedDay';
    } else if( fromSelectedMonth < 10 && fromSelectedDay < 10 ) {
      startDate = '$fromSelectedYear-0$fromSelectedMonth-0$fromSelectedDay';
    }

    if( toSelectedMonth < 10 ) {
      lastDate = '$toSelectedYear-0$toSelectedMonth-$toSelectedDay';
    } else if( toSelectedDay < 10 ) {
      lastDate = '$toSelectedYear-$toSelectedMonth-0$toSelectedDay';
    } else if( fromSelectedMonth < 10 && toSelectedDay < 10 ) {
      lastDate = '$toSelectedYear-0$toSelectedMonth-0$toSelectedDay';
    }

    historyList = await transactionCollection
        .where('processState', isEqualTo: 'pickedUp')
        .where('orderTime', isGreaterThanOrEqualTo: startDate)
        .where('orderTime', isLessThanOrEqualTo: lastDate)
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