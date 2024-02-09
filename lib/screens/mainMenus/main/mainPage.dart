import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/screens/mainMenus/main/dessertWidget.dart';
import 'package:oasis_cafe_app/screens/mainMenus/main/helloWidget.dart';
import 'package:oasis_cafe_app/screens/mainMenus/main/newsWidget.dart';
import 'orderStatusWidget.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // 'Hello'
              HelloWidget(),
              Gaps.gapH30,
              OrderStatus(),
              Gaps.gapH30,
              // 소식(What's New)
              NewsWidget(),
              Gaps.gapH30,
              // 디저트(하루가 달콤해지는 시간)
              DessertWidget()
            ],
          ),
        ),
      ),
    );
  }
}

