import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/menuDetailProvider.dart';
import 'package:provider/provider.dart';

class MenuDetailPage extends StatelessWidget {
  const MenuDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<MenuDetailProvider>(context);

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
