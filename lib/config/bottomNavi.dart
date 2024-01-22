import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/localNotification.dart';
import 'package:oasis_cafe_app/screens/mainMenus/main/mainPage.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/orderPage.dart';

import '../screens/mainMenus/other/otherPage.dart';
import 'palette.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {

  int _selectedIndex = 0;
  static const List<Widget> _pageList = [
    MainPage(),
    OrderPage(),
    OtherPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    // notification 초기화
    LocalNotification.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageList.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.coffee), label: 'order'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'other')
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Palette.buttonColor1,
        onTap: _onItemTapped,
      ),
    );
  }
}
