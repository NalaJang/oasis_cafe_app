import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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

              // 멤버쉽 카드 또는 주문 상태
              // Container(
              //   height: 200,
              //   // margin: EdgeInsets.symmetric(horizontal: 20.0),
              //   decoration: BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(5),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.3),
              //           blurRadius: 5,
              //           spreadRadius: 2
              //         )
              //       ]
              //   ),
              // ),
              OrderStatus(),

              SizedBox(height: 30,),

              // 소식(What's New)
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

                  SizedBox(height: 10,),

                  Image.asset(
                      'image/IMG_banner2.PNG'
                  ),
                ],
              ),

              SizedBox(height: 30,),

              // 디저트(하루가 달콤해지는 시간)
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

              SizedBox(height: 10,),

              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('image/IMG_dessert1.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert2.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert1.PNG'),
                    SizedBox(width: 10,),
                    Image.asset('image/IMG_dessert2.PNG'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderStatus extends StatefulWidget {
  const OrderStatus({Key? key}) : super(key: key);

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {

  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<UserStateProvider>(context).userName;

    return Container(
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

      child: Column(
        children: [
          Text(
            '$userName 님의 주문을 1번째 메뉴로 준비 중입니다.',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            ),
          ),


          Image.asset('image/IMG_order_status_graph.png'),

          Text('주문내역 확인하기')
        ],
      ),
    );
  }
}

