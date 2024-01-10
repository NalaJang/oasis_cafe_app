import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:provider/provider.dart';

import '../../../provider/userStateProvider.dart';
import '../../../strings/strings_en.dart';
import 'cart/cart.dart';

class MenuListFirst extends StatelessWidget {
  const MenuListFirst({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuDetailProvider = Provider.of<ItemProvider>(context);
    final userStateProvider = Provider.of<UserStateProvider>(context);

    // TabViewList class 에서 넘어온 arguments 를 받는다.
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;
    String documentName = arguments[0].toString();
    String collectionName = arguments[1].toString();
    menuDetailProvider.setCollectionReference(documentName, collectionName);

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionName),
      ),

      // 장바구니 버튼
      floatingActionButton: userStateProvider.userUid != '' ?
      FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Cart()
              )
          );
        },
        child: Icon(CupertinoIcons.cart),
      ) : null,

      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: FutureBuilder(
          future: menuDetailProvider.fetchItems(),
          builder: (context, snapshot) {

            if( menuDetailProvider.items.isEmpty ) {
              return const Center(
                child: CircularProgressIndicator(),
              );

            } else {

              return ListView.builder(
                itemCount: menuDetailProvider.items.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ListTile(

                      leading: Image.asset(
                        'image/IMG_espresso.png',
                      ),

                      title: Text(menuDetailProvider.items[index].title),
                      subtitle: Text(menuDetailProvider.items[index].subTitle),

                      onTap: (){
                        Navigator.pushNamed(context, Strings.menuListSecond,
                          arguments: [
                            menuDetailProvider.items[index]
                          ]
                        );
                      },
                    ),
                  );
                }
              );
            }
          },
        ),
      ),
    );
  }
}
