import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/cartProvider.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../config/palette.dart';
import '../../../strings/strings_en.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Review Order'),
      ),

      // 주문하기
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

    final cartProvider = Provider.of<CartProvider>(context);


    // 아이템 삭제 다이얼로그
    void setShowDialog(String itemId) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('선택한 메뉴를 삭제하시겠습니까?',),
              actions: [

                // 취소 버튼
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

                // 삭제 버튼
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var isDeleted = cartProvider.deleteItemFromCart(itemId);

                      if( await isDeleted ) {
                        // ScaffoldMessenger.of(context) 에
                        // 'Don't use 'BuildContext's across async gaps.' 라는 경고가 떠 있었다.
                        // 비동기 시 BuildContext 를 암시적으로 저장되고 쉽게 충돌 진단이 어려울 수 있다.
                        // 때문에 async 사용 후엔 반드시 BuildContext 가 mount 되었는 지 확인해주어야 한다고 한다.
                        if( mounted ) {
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('삭제되었습니다.')
                              )
                          );
                        }
                      }

                    } catch(e) {
                      if( mounted ) {

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(e.toString())
                            )
                        );
                      }
                    }

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
      cartProvider.updateItemQuantity(itemId, quantity, totalPrice);
    }

    // 변경 FutureBuilder -> StreamBuilder
    // FutureBuilder 의 future 속성에서야 item 을 가져오다보니
    // 아이템을 새로 장바구니에 넣고 장바구니 화면으로 올 때마다 달라진 length 를 늦게 가져오게 되고
    // 아이템 수량 변경을 위해 전역 변수로 선언한 quantities 의 값도 늦게 변하게 되면서
    // RangeError (index) 가 장바구니 아이템 개수가 변할 때마다 발생했다.
    // 따라서 StreamBuilder 로 바꾸어서 실시간으로 fireStore 변화를 읽게 하도록 했다.
    return StreamBuilder(
      stream: cartProvider.cartCollection.snapshots(),
      builder: (BuildContext context , AsyncSnapshot<QuerySnapshot> streamSnapshot) {

        if( streamSnapshot.hasData ) {

          // provider 에 데이터를 리스트 형태로 저장
          cartProvider.fetchCartItems();

          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.grey,
            ),
            itemCount: streamSnapshot.data!.docs.length,
            itemBuilder: (context, index) {

              final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
              String itemId = documentSnapshot.id;
              String itemName = documentSnapshot['itemName'];
              String itemPrice = documentSnapshot['itemPrice'];
              double totalPrice = documentSnapshot['totalPrice'];
              int quantity  = documentSnapshot['quantity'];
              String drinkSize = documentSnapshot['drinkSize'];
              String cup = documentSnapshot['cup'];
              int espressoOption = documentSnapshot['espressoOption'];
              String hotOrIced = documentSnapshot['hotOrIced'];
              String syrupOption = documentSnapshot['syrupOption'];
              String whippedCreamOption = documentSnapshot['whippedCreamOption'];
              String iceOption = documentSnapshot['iceOption'];

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
                                        child: Text('${quantity}'),
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
            },
          );
        }
        return Center(child: CircularProgressIndicator());
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

    final transactionHistoryProvider = Provider.of<TransactionHistoryProvider>(context);
    final String userUid = FirebaseAuth.instance.currentUser!.uid;
    final cartProvider = Provider.of<CartProvider>(context);

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
        onTap: () async {
          var now = DateTime.now();
          var year = now.year.toString();
          var month = now.month.toString();
          var day = now.day.toString();
          var hour = now.hour.toString();
          var dateFormatter = DateFormat('Hms');
          var time = dateFormatter.format(now);
          List<String> orderedItemsId = [];
          var isOrdered;


          try {
            for( var i = 0; i < cartProvider.cartItems.length; i++ ) {
              int quantity = cartProvider.cartItems[i].quantity;
              String itemName = cartProvider.cartItems[i].itemName;
              String itemPrice = cartProvider.cartItems[i].itemPrice;
              double totalPrice = cartProvider.cartItems[i].totalPrice;
              String drinkSize = cartProvider.cartItems[i].drinkSize;
              String cup = cartProvider.cartItems[i].cup;
              int espressoOption = cartProvider.cartItems[i].espressoOption;
              String hotOrIced = cartProvider.cartItems[i].hotOrIced;
              String syrupOption = cartProvider.cartItems[i].syrupOption;
              String whippedCreamOption = cartProvider.cartItems[i].whippedCreamOption;
              String iceOption = cartProvider.cartItems[i].iceOption;

              isOrdered = transactionHistoryProvider.orderItems(userUid, year, month, day, hour, time,
                        quantity, itemName, itemPrice, totalPrice, drinkSize, cup, hotOrIced,
                        espressoOption, syrupOption, whippedCreamOption, iceOption);

              orderedItemsId.add(cartProvider.cartItems[i].id);
            }

            // 주문이 정상 처리됐을 경우
            if( await isOrdered ) {
              // 주문한 아이템 장바구니에서 삭제
              cartProvider.deleteAllItemsFromCart(orderedItemsId);

              if( mounted ) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        '주문이 완료되었습니다.'
                    )
                  )
                );
              }
            }

          } catch(e) {
            if( mounted ) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      e.toString()
                  )
                )
              );
            }
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

