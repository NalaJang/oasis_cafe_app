import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oasis_cafe_app/strings/strings.dart';

class MenuDetailProvider with ChangeNotifier {
  late CollectionReference _collectionReference;
  final db = FirebaseFirestore.instance;

  List<String> items = [];

  // MenuDetailProvider({reference}) {
  //   _collectionReference = reference ??
  //   FirebaseFirestore.instance.collection('order').doc('beverage').collection('espresso');
  // }

  void setCollectionReference(String documentName, String collectionName) {
    _collectionReference =
        FirebaseFirestore.instance.collection(Strings.order).doc(documentName).collection(collectionName);
  }

  Future<void> fetchItems() async {
    items = await _collectionReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return document.id;
      }).toList();
    });
    notifyListeners();
  }


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