import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app/model/model_ingredients.dart';
import 'package:oasis_cafe_app/model/model_item.dart';
import 'package:oasis_cafe_app/strings/strings.dart';

class MenuDetailProvider with ChangeNotifier {
  late CollectionReference _collectionReference;
  late CollectionReference _ingredientsCollectionReference;
  final db = FirebaseFirestore.instance;

  List<ItemModel> items = [];
  List<IngredientsModel> ingredients = [];

  String getDocumentName ='';
  String getCollectionName = '';


  void setCollectionReference(String documentName, String collectionName) {
    getDocumentName = documentName;
    getCollectionName = collectionName;
    _collectionReference =
        FirebaseFirestore.instance.collection(Strings.order).doc(documentName).collection(collectionName);
  }

  void setIngredientsCollectionReference(String documentName, String collectionName, String itemId) {
    _ingredientsCollectionReference =
        FirebaseFirestore.instance.collection(Strings.order)
            .doc(documentName).collection(collectionName)
            .doc(itemId).collection(Strings.ingredients);
  }

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
      int espressoOption,
      String syrupOption,
      String whippedCreamOption,
      String iceOption
      ) async {
    await db.collection(Strings.collection_user).doc(userUid).collection(Strings.collection_userCart).add(
        {
          'drinkSize' : drinkSize,
          'cup' : cup,
          'hotOrIced' : hotOrIced,
          'selectedItem' : selectedItem,
          'espressoOption' : espressoOption,
          'syrupOption' : syrupOption,
          'whippedCreamOption' : whippedCreamOption,
          'iceOption' : iceOption
        }
    );
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