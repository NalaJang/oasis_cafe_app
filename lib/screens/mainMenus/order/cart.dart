import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    final String userUid = userStateProvider.userUid;

    return Scaffold(
      appBar: AppBar(
        title: Text('CartPage'),
      ),

      body: FutureBuilder(
        future: itemProvider.getItemsFromCart(userUid),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: itemProvider.cartItems.length,
            itemBuilder: (context, index) {

              return
            }
          );

        }
      ),
    );
  }
}
