import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/commonTextStyle.dart';
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
          title: Text(
            Strings.intlMessage('order'),
            style: CommonTextStyle.fontSize30,
          ),

          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.search,
                size: 30,
              )
            )
          ],

          bottom: TabBar(
            indicatorColor: Palette.buttonColor1,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal
            ),

            tabs: [
              Tab(text: Strings.intlMessage('beverage')),
              Tab(text: Strings.intlMessage('food')),
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
