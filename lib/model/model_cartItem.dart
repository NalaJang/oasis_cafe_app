import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {

  late String itemName;
  late String drinkSize;
  late String cup;

  CartItemModel.getSnapshotDataFromCart(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    drinkSize = data['drinkSize'];
  }
}