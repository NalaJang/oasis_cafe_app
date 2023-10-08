import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../config/palette.dart';
import '../../../strings/strings.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('CartPage'),
      ),

      bottomNavigationBar: _OrderButton(),

      body: CartItems(),

    );
  }
}

class CartItems extends StatefulWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {

  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    final String userUid = userStateProvider.userUid;


    // 메뉴 삭제 다이얼로그
    void setShowDialog(String itemId) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('선택한 메뉴를 삭제하시겠습니까?',),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },

                  child: Text('아니오'),

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    side: BorderSide(
                      color: Colors.teal,
                      width: 1
                    )
                  ),
                ),

                SizedBox(width: 10,),

                ElevatedButton(
                  onPressed: (){
                    itemProvider.deleteItemFromCart(itemId, context);
                  },

                  child: Text('삭제'),

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)
                    ),
                    side: BorderSide(
                        color: Colors.teal,
                        width: 1
                    )
                  ),
                )
              ],
            );
          }
      );
    }

    // 아이템 수량
    // 변경된 수량 및 가격 업데이트
    void setQuantity(String itemId, int quantity, double price) {
      double totalPrice = quantity * price;
      itemProvider.updateItemQuantity(itemId, quantity, totalPrice);
    }

    return FutureBuilder(
      future: itemProvider.getItemsFromCart(userUid),
      builder: (context, snapshot) {
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.grey,
          ),

          itemCount: itemProvider.cartItems.length,
          itemBuilder: (context, index) {
            int quantity = itemProvider.cartItems[index].quantity;
            String itemId = itemProvider.cartItems[index].id;
            String itemName = itemProvider.cartItems[index].itemName;
            String itemPrice = itemProvider.cartItems[index].itemPrice;
            double totalPrice = itemProvider.cartItems[index].totalPrice;
            String drinkSize = itemProvider.cartItems[index].drinkSize;
            String cup = itemProvider.cartItems[index].cup;
            int espressoOption = itemProvider.cartItems[index].espressoOption;
            String hotOrIced = itemProvider.cartItems[index].hotOrIced;
            String syrupOption = itemProvider.cartItems[index].syrupOption;
            String whippedCreamOption = itemProvider.cartItems[index].whippedCreamOption;
            String iceOption = itemProvider.cartItems[index].iceOption;

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [

                  Row(
                    children: [

                      // 아이템 삭제
                      IconButton(
                          onPressed: (){
                            setShowDialog(itemId);
                          },
                          icon: Icon(CupertinoIcons.xmark_circle)
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Image.asset(
                        'image/IMG_espresso.png',
                        scale: 2.0,
                      ),

                      // 아이템 정보
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${itemName}',
                              style: TextStyle(
                                fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            SizedBox(height: 10,),

                            // hotOrIced, 사이즈, 컵 옵션
                            Row(
                              children: [
                                Text(hotOrIced),
                                Text(' | '),
                                Text(drinkSize),
                                Text(' | '),
                                Text(cup)
                              ],
                            ),

                            //// 옵션 사항
                            // 에스프레소
                            espressoOption != 2 ? Text('$espressoOption') : SizedBox(height: 0,),
                            // 시럽
                            syrupOption != "" ? Text(syrupOption) : SizedBox(height: 0,),
                            // 휘핑 크림
                            whippedCreamOption != "" ? Text(whippedCreamOption) : SizedBox(height: 0,),
                            // 얼음
                            iceOption != "" ? Text('얼음 $iceOption') : SizedBox(height: 0,),

                            SizedBox(height: 20,),

                            // 수량 및 가격
                            Row(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        if( quantity > 1 ) {
                                          quantity--;
                                        }
                                        setQuantity(itemId, quantity, double.parse(itemPrice));
                                      },
                                      child: Icon(
                                        CupertinoIcons.minus_circle,
                                        color: quantity > 1 ? Colors.black : Colors.grey,
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.only(left: 20, right: 20),
                                      child: Text('$quantity'),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        quantity++;
                                        setQuantity(itemId, quantity, double.parse(itemPrice));
                                      },
                                      child: Icon(CupertinoIcons.plus_circle),
                                    ),

                                  ],
                                ),

                                SizedBox(width: 50,),

                                Text('NZD $totalPrice')
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}

class _OrderButton extends StatefulWidget {
  const _OrderButton({Key? key}) : super(key: key);

  @override
  State<_OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<_OrderButton> {
  var color = Color(0xffe8e8e8);

  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);
    final String userUid = userStateProvider.userUid;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(
          color: color
        )),
        boxShadow: [
          BoxShadow(
            color: color,
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(3, 0)
          )
        ]

      ),
      child: GestureDetector(
        onTap: (){
          var now = DateTime.now();
          var year = now.year.toString();
          var month = now.month.toString();
          var day = now.day.toString();
          var dateFormatter = DateFormat('Hms');
          var time = dateFormatter.format(now);

          for( var i = 0; i < itemProvider.cartItems.length; i++ ) {
            int quantity = itemProvider.cartItems[i].quantity;
            String itemName = itemProvider.cartItems[i].itemName;
            String itemPrice = itemProvider.cartItems[i].itemPrice;
            double totalPrice = itemProvider.cartItems[i].totalPrice;
            String drinkSize = itemProvider.cartItems[i].drinkSize;
            String cup = itemProvider.cartItems[i].cup;
            int espressoOption = itemProvider.cartItems[i].espressoOption;
            String hotOrIced = itemProvider.cartItems[i].hotOrIced;
            String syrupOption = itemProvider.cartItems[i].syrupOption;
            String whippedCreamOption = itemProvider.cartItems[i].whippedCreamOption;
            String iceOption = itemProvider.cartItems[i].iceOption;

            transactionHistoryProvider.orderItems(userUid, year, month, day, time,
                quantity, itemName, itemPrice, totalPrice, drinkSize, cup, hotOrIced,
                espressoOption, syrupOption, whippedCreamOption, iceOption);
          }
        },

        child: Container(
          padding: EdgeInsets.all(15.0),
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),

          decoration: BoxDecoration(
            color: Palette.buttonColor1,
            border: Border.all(color: Palette.buttonColor1, width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),

          child: const Text(
            Strings.order,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}

