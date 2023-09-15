import 'package:cloud_firestore/cloud_firestore.dart';

class IngredientsModel {
  late String id;
  late String espresso;
  late String syrup;
  late String milk;
  late String whippedCream;

  IngredientsModel.getIngredients(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    espresso = data['espresso'];
    syrup = data['syrup'];
    milk = data['milk'];
    whippedCream = data['whippedCream'];
  }
}