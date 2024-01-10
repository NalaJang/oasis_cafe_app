import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/cart/cart.dart';
import 'package:provider/provider.dart';

import '../strings/strings_en.dart';

class TabViewList extends StatelessWidget {
  const TabViewList(this.currentTabIndex, {Key? key}) : super(key: key);

  final int currentTabIndex;

  @override
  Widget build(BuildContext context) {

    final db = FirebaseFirestore.instance;
    String collectionName = Strings.beverage;

    String getCollectionName() {

      if( currentTabIndex == 0 ) {
        collectionName = Strings.beverage;
      } else if( currentTabIndex == 1 ) {
        collectionName = Strings.food;
      }

      return collectionName;
    }

    CollectionReference collectionReference = db.collection(getCollectionName());
    final userStateProvider = Provider.of<UserStateProvider>(context);

    return Scaffold(

      // 장바구니 버튼
      floatingActionButton: userStateProvider.userUid != '' ?
      FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Cart()
            )
          );
        },
        child: const Icon(CupertinoIcons.cart),
      ) : null,

      body: StreamBuilder(
        stream: collectionReference.snapshots(),
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
                    Navigator.pushNamed(
                      context, Strings.menuListFirst,
                      arguments: [
                        getCollectionName(),
                        documentSnapshot['subTitle']
                      ]
                    );
                  },
                );
              }
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
