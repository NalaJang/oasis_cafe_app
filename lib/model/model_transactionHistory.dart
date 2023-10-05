import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionHistoryModel {

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

  TransactionHistoryModel.getSnapshotDataFromUserOrder(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    itemName = data['itemName'];
    itemPrice = data['itemPrice'];
    drinkSize = data['drinkSize'];
    cup = data['cup'];
    espressoOption = data['espressoOption'];
    hotOrIced = data['hotOrIced'];
    syrupOption = data['syrupOption'];
    whippedCreamOption = data['whippedCreamOption'];
    iceOption = data['iceOption'];

  }
}