import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // tabBar menu 수 지정
      length: 3,
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

          bottom: TabBar(
            padding: EdgeInsets.only(top: 20),
            tabs: [
              Tab(text: '음료',),
              Tab(text: '푸드',),
              Tab(text: '상품',)
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            Text('tab1'),
            Text('tab2'),
            Text('tab3')
          ],
        )
      ),
    );
  }
}
