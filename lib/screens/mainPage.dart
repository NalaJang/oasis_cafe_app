import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            // 'Hello'
            Container(
              height: 210.0,
              padding: const EdgeInsets.only(top: 100, left: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 35
                    ),
                  ),

                  SizedBox(width: 5,),

                  Icon(
                    Icons.coffee,
                    size: 40,
                  ),
                ],
              ),
            ),

            // 주문 상태
            Container(
              height: 200,
              // margin: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 5,
                      spreadRadius: 2
                    )
                  ]
              ),
            ),

            SizedBox(height: 30,),

            // 소식
            Row(
              children: [
                Icon(
                  Icons.mail_outline_sharp,
                  size: 20,
                ),

                SizedBox(width: 5,),

                Text(
                  "What's New",
                  style: TextStyle(
                    fontSize: 15
                  ),
                )
              ],
            ),

            SizedBox(height: 10,),

            Column(
              children: [
                Image.asset(
                    'image/IMG_banner1.PNG'
                ),

                Image.asset(
                    'image/IMG_banner2.PNG'
                ),
              ],
            ),

            // 디저트
            Row(
              children: [
                Text(
                  '하루가 달콤해지는 시간',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
