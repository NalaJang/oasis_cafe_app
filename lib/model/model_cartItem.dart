import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {

  late String itemName;
  late String itemPrice;
  late String drinkSize;
  late String cup;
  late String espressoOption;
  late String hotOrIced;
  late String syrupOption;
  late String whippedCreamOption;
  late String iceOption;

  CartItemModel.getSnapshotDataFromCart(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

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