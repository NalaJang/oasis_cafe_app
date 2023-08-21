import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 70, right: 20, left: 20, bottom: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.search,
                    size: 30,
                  ),
                ],
              ),

              SizedBox(height: 50,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Order',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
