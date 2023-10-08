import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/model/model_cartItem.dart';
import 'package:oasis_cafe_app/model/model_ingredients.dart';
import 'package:oasis_cafe_app/model/model_item.dart';
import 'package:oasis_cafe_app/strings/strings.dart';

class ItemProvider with ChangeNotifier {
  late CollectionReference _collectionReference;
  late CollectionReference _ingredientsCollectionReference;
  late CollectionReference _cartCollection;
  final db = FirebaseFirestore.instance;

  List<ItemModel> items = [];
  List<IngredientsModel> ingredients = [];
  List<CartItemModel> cartItems = [];

  String getDocumentName ='';
  String getCollectionName = '';


  void setCollectionReference(String documentName, String collectionName) {
    getDocumentName = documentName;
    getCollectionName = collectionName;
    _collectionReference =
        FirebaseFirestore.instance.collection(Strings.order).doc(documentName).collection(collectionName);
  }

  // void setIngredientsCollectionReference(String documentName, String collectionName, String itemId) {
  //   _ingredientsCollectionReference =
  //       FirebaseFirestore.instance.collection(Strings.order)
  //           .doc(documentName).collection(collectionName)
  //           .doc(itemId).collection(Strings.ingredients);
  // }

  Future<void> fetchItems() async {
    items = await _collectionReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return ItemModel.getSnapshotData(document);
      }).toList();
    });
    notifyListeners();
  }

  Future<void> fetchIngredients() async {
    ingredients = await _ingredientsCollectionReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return IngredientsModel.getIngredients(document);
      }).toList();
    });
    notifyListeners();
  }


  // 장바구니에 선택한 음료 담기
  Future<void> addItemsToCart(
      String userUid,
      String drinkSize,
      String cup,
      String hotOrIced,
      String selectedItem,
      String selectedItemPrice,
      int espressoOption,
      String syrupOption,
      String whippedCreamOption,
      String iceOption
      ) async {
    await db.collection(Strings.collection_user).doc(userUid).collection(Strings.collection_userCart).add(
        {
          'quantity'  : 1,
          'drinkSize' : drinkSize,
          'cup' : cup,
          'hotOrIced' : hotOrIced,
          'itemName' : selectedItem,
          'itemPrice' : selectedItemPrice,
          'totalPrice' : 0,
          'espressoOption' : espressoOption,
          'syrupOption' : syrupOption,
          'whippedCreamOption' : whippedCreamOption,
          'iceOption' : iceOption
        }
    );
  }

  Future<void> getItemsFromCart(String userUid) async {
    _cartCollection = db.collection(Strings.collection_user).doc(userUid).collection(Strings.collection_userCart);

    cartItems = await _cartCollection.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return CartItemModel.getSnapshotDataFromCart(document);
      }).toList();
    });
    notifyListeners();
  }


  // 장바구니 수량 및 가격 업데이트
  Future<void> updateItemQuantity(String itemId, int quantity, double totalPrice) async {

    await _cartCollection.doc(itemId).update({
      'quantity' : quantity,
      'totalPrice' : totalPrice
    });

    await _cartCollection.doc(itemId).get().then((value) => {
      CartItemModel.getUpdatedQuantityAndPrice(value)
    });

    notifyListeners();
  }


  // 장바구니에서 아이템 삭제
  Future<void> deleteItemFromCart(String itemId, BuildContext context) async {
    await _cartCollection.doc(itemId).delete();

    // ScaffoldMessenger.of(context) 에
    // 'Don't use 'BuildContext's across async gaps.' 라는 경고가 떠 있었다.
    // 비동기 시 BuildContext 를 암시적으로 저장되고 쉽게 충돌 진단이 어려울 수 있다.
    // 때문에 async 사용 후엔 반드시 BuildContext 가 mount 되었는 지 확인해주어야 한다고 한다.
    if( context.mounted ) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('삭제되었습니다.')
          )
      );
    }
  }

  // getIngredients() {
  //   db.collection('Order').doc('Beverage').collection('Espresso')
  //       .doc().collection('ingredients')
  //       .get().then( (querySnapshot) {
  //         // print('${querySnapshot.docs}');
  //     for (var docSnapshot in querySnapshot.docs) {
  //       print('${docSnapshot.id} => ${docSnapshot.data()}');
  //     }
  //   });
  // }


  // String getItem() {
  //   String result ='';
  //
  //   db.collection("order").doc('beverage').collection('espresso').get().then(
  //         (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         print('${docSnapshot.id} => ${docSnapshot.data()}');
  //         result = '${docSnapshot.id} => ${docSnapshot.data()}';
  //       }
  //     },
  //     onError: (e) {
  //       print("Error completing: $e");
  //       result = 'error : $e';
  //     }
  //   );
  //
  //   return result;
  // }
}