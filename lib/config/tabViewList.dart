import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final db = FirebaseFirestore.instance;
CollectionReference _collectionReference = db.collection('beverage');

class TabViewList extends StatelessWidget {
  const TabViewList(this.currentTabIndex, {Key? key}) : super(key: key);

  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _collectionReference.snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot> streamSnapshot) {

        if( streamSnapshot.hasData ) {
          return ListView.builder(
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

              return ListTile(
                title: Text(documentSnapshot['title']),
                subtitle: Text(documentSnapshot['subTitle']),
                onTap: () {
                  Navigator.pushNamed(context, '/menuDetail');
                },
              );
            }
          );

        } else {
          print('no data');
        }

        return Center(child: CircularProgressIndicator());

      },
    );
  }
}
