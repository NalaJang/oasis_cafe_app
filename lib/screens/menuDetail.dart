import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/menuDetailProvider.dart';
import 'package:provider/provider.dart';

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuDetailProvider = Provider.of<MenuDetailProvider>(context);

    // TabViewList class 에서 넘어온 arguments 를 받는다.
    final List arguments = ModalRoute.of(context)!.settings.arguments as List;
    String documentName = arguments[0].toString();
    String collectionName = arguments[1].toString();
    menuDetailProvider.setCollectionReference(documentName, collectionName);

    return Scaffold(
      appBar: AppBar(
        title: Text(collectionName),
      ),

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
                        String itemId = menuDetailProvider.items[index].id;
                        // menuDetailProvider.setIngredientsCollectionReference(documentName, collectionName, itemId);

                        Navigator.pushNamed(context, '/selectedItem',
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
