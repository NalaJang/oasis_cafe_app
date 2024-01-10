import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:provider/provider.dart';

import '../strings/strings_en.dart';

class CartProvider with ChangeNotifier {
  final db = FirebaseFirestore.instance;
  late CollectionReference cartCollection;
  List<CartProvider> cartItems = [];
  List<String> orderedItemsId = [];
  bool hasCartData = false;
  bool isSaved = true;
  bool isOrdered = true;
  String lastOrderUid = '';

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
  Future<void> deleteAllItemsFromCart() async {
    for( var i = 0; i < orderedItemsId.length; i++ ) {
      await cartCollection.doc(orderedItemsId[i]).delete();
    }
    notifyListeners();
  }


  // 주문 넣기
  Future<bool> placeAnOrder(BuildContext context, String userUid) async {
    var now = DateTime.now();
    var dateFormatter = DateFormat('yyyy-MM-dd H:m:s');
    var time = dateFormatter.format(now);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    for( var i = 0; i < cartProvider.cartItems.length; i++ ) {
      int quantity = cartProvider.cartItems[i].quantity;
      String itemName = cartProvider.cartItems[i].itemName;
      String itemPrice = cartProvider.cartItems[i].itemPrice;
      double totalPrice = cartProvider.cartItems[i].totalPrice;
      String drinkSize = cartProvider.cartItems[i].drinkSize;
      String cup = cartProvider.cartItems[i].cup;
      int espressoOption = cartProvider.cartItems[i].espressoOption;
      String hotOrIced = cartProvider.cartItems[i].hotOrIced;
      String syrupOption = cartProvider.cartItems[i].syrupOption;
      String whippedCreamOption = cartProvider.cartItems[i].whippedCreamOption;
      String iceOption = cartProvider.cartItems[i].iceOption;

      orderedItemsId.add(cartProvider.cartItems[i].id);

      isOrdered = await TransactionHistoryProvider().orderItems(userUid, time,
          quantity, itemName, itemPrice, totalPrice, drinkSize, cup, hotOrIced,
          espressoOption, syrupOption, whippedCreamOption, iceOption);
    }

    return isOrdered;
  }
}