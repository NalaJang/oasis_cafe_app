import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  late String id;
  late String title;
  late String subTitle;
  late String price;
  late String description;
  late String imageUrl;

  ItemModel.getSnapshotData(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    id = snapshot.id;
    title = data['title'];
    subTitle = data['subTitle'];
    price = data['price'];
    description = data['description'];
    imageUrl = data['imageUrl'];
  }
}