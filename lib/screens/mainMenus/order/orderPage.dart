import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/tabViewList.dart';

import '../../../strings/strings_en.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  final tabBarLength = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tabBar menu 수 지정
      length: tabBarLength,
      child: Scaffold(
        appBar: AppBar(
          // 뒤로가기 화살표 없애기
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Padding(
            padding: EdgeInsets.only(top:10),
            child: Text(
              Strings.order,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),

          actions: [
            IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.search,
                size: 30,
              )
            )
          ],

          bottom: const TabBar(
            padding: EdgeInsets.only(top: 20),
            indicatorColor: Palette.buttonColor1,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal
            ),

            tabs: [
              Tab(text: Strings.beverage),
              Tab(text: Strings.food),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            for( int i = 0; i < tabBarLength; i++ )
              TabViewList(i)

          ],
        ),
      ),
    );
  }
}
