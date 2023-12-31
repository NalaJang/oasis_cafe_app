import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../strings/strings_en.dart';

class CartProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  late CollectionReference cartCollection;
  List<CartProvider> cartItems = [];
  bool hasCartData = false;

  late String id;
  late int quantity;
  late String itemName;
  late String itemPrice;
  late double totalPrice;
  late String drinkSize;
  late String cup;
  late int espressoOption;
  late String hotOrIced;
  late String syrupOption;
  late String whippedCreamOption;
  late String iceOption;

  CartProvider() {
    String userUid = FirebaseAuth.instance.currentUser!.uid;
    cartCollection = db.collection(Strings.collection_user)
                      .doc(userUid)
                      .collection(Strings.collection_userCart);
  }


  // 데이터 가져와서 변수에 할당
  CartProvider.getCartSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    quantity = data['quantity'];
    itemName = data['itemName'];
    itemPrice = data['itemPrice'];
    totalPrice = data['totalPrice'];
    drinkSize = data['drinkSize'];
    cup = data['cup'];
    espressoOption = data['espressoOption'];
    hotOrIced = data['hotOrIced'];
    syrupOption = data['syrupOption'];
    whippedCreamOption = data['whippedCreamOption'];
    iceOption = data['iceOption'];

  }


  Future<void> fetchCartItems() async {
    cartItems = await cartCollection.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return CartProvider.getCartSnapshotData(document);
      }).toList();
    });

    notifyListeners();
  }

  // 장바구니 수량 및 가격 업데이트
  Future<void> updateItemQuantity(String itemId, int quantity, double totalPrice) async {

    await cartCollection.doc(itemId).update({
      'quantity' : quantity,
      'totalPrice' : totalPrice
    });
  }


  // 장바구니에서 아이템 삭제
  Future<bool> deleteItemFromCart(String itemId) async {
    await cartCollection.doc(itemId).delete();
    return true;
  }


  // 주문한 아이템 장바구니에서 삭제
  Future<void> deleteAllItemsFromCart(List<String> itemList) async {

    for( var i = 0; i < itemList.length; i++ ) {
      await cartCollection.doc(itemList[i]).delete();
    }
  }
}