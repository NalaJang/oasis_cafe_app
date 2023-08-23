import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/tabViewList.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  final tabBarLength = 3;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tabBar menu 수 지정
      length: tabBarLength,
      child: Scaffold(
        appBar: AppBar(
          // 뒤로가기 화살표 없애기
          automaticallyImplyLeading: false,

          title: Padding(
            padding: const EdgeInsets.only(top:10),
            child: Text(
              'Order',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
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
            tabs: [
              Tab(text: '음료',),
              Tab(text: '푸드',),
              Tab(text: '상품',)
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
