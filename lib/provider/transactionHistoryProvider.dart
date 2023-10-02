import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../strings/strings.dart';

class TransactionHistoryProvider with ChangeNotifier {
  late String id;
  late String itemName;
  late String itemPrice;
  late String drinkSize;
  late String cup;
  late int espressoOption;
  late String hotOrIced;
  late String syrupOption;
  late String whippedCreamOption;
  late String iceOption;

  final db = FirebaseFirestore.instance;

  Future<void> orderItems(
      String userUid,
      String year,
      String month,
      String day,
      String time,
      String itemName,
      String itemPrice,
      String drinkSize,
      String cup,
      String hotOrIced,
      int espressoOption,
      String syrupOption,
      String whippedCreamOption,
      String iceOption
      ) async {
    await db.collection(Strings.collection_user).doc(userUid)
        .collection('user_order').doc(year)
        .collection(month).doc(day)
        .collection(time)
        .add(
        {
          'itemName' : itemName,
          'itemPrice' : itemPrice,
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
}