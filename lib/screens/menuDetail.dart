import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/menuDetailProvider.dart';
import 'package:provider/provider.dart';

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<MenuDetailProvider>(context);

    // TabViewList class 에서 넘어온 arguments 를 받는다.
    final List items = ModalRoute.of(context)!.settings.arguments as List;
    String documentName = items[0].toString();
    String collectionName = items[1].toString();
    itemProvider.setCollectionReference(documentName, collectionName);

    return FutureBuilder(
      future: itemProvider.fetchItems(),
      builder: (context, snapshot) {
        return Scaffold(
            appBar: AppBar(
              title: Text('menuDetail'),
            ),

            body: ListView.builder(
                itemCount: itemProvider.items.length,
                itemBuilder: (context, index) {
                  return Text('${itemProvider.items[index]}');
                }
            )
        );
      },
    );
  }
}
