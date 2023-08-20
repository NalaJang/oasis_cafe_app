import 'package:flutter/material.dart';

import 'palette.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;
  static const List<Widget> _pageList = [
    Text('index 0'),
    Text('index 1'),
    Text('index 2')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
