import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print('loggedUser: ${loggedUser!.email}');
      }

    } catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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

      child: Text(loggedUser!.uid.toString()),
    );
  }
}

