import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/provider/cartProvider.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';
import 'package:provider/provider.dart';

import '../../../../config/palette.dart';
import 'orderButton.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.intlMessage('cart')),
      ),

      // 주문하기
      bottomNavigationBar: const OrderButton(),

      body: const CartItems(),

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
              content: Text(Strings.intlMessage('deleteItem')),
              actions: [

                // 취소 버튼
                ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    side: const BorderSide(color: Palette.buttonColor1,)
                  ),

                  child: Text(Strings.intlMessage('no')),
                ),

                Gaps.gapW10,

                // 삭제 버튼
                ElevatedButton(
                  onPressed: () async {
                    try {
                      var isDeleted = cartProvider.deleteItemFromCart(itemId);

                      if( await isDeleted ) {

                        setState(() {
                          // 장바구니 내역이 모두 삭제되어서 비게 되면, 'Order' 버튼의 UI 를 refresh 해줘야 하기 때문.
                          // 장바구니 내역을 불러오는 코드에서 계속 true 값을 리턴하기 때문에
                          // 2개 중 하나만 삭제해서 내역이 남아 있어도 버튼이 비활성화 되지는 않는다.
                          cartProvider.hasCartData = false;
                        });

                        // ScaffoldMessenger.of(context) 에
                        // 'Don't use 'BuildContext's across async gaps.' 라는 경고가 떠 있었다.
                        // 비동기 시 BuildContext 를 암시적으로 저장되고 쉽게 충돌 진단이 어려울 수 있다.
                        // 때문에 async 사용 후엔 반드시 BuildContext 가 mount 되었는 지 확인해주어야 한다고 한다.
                        if( mounted ) {
                          Navigator.of(context).pop();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(Strings.intlMessage('showDeleteSnackBar'))
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

                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    foregroundColor: Colors.white,
                    backgroundColor: Palette.buttonColor1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)
                    ),
                    side: const BorderSide(color: Palette.buttonColor1,)
                  ),

                  child: Text(Strings.intlMessage('delete')),
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

          if( streamSnapshot.data!.docs.isEmpty ) {
            cartProvider.hasCartData = false;

          } else {
            cartProvider.hasCartData = true;

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
                              icon: const Icon(CupertinoIcons.xmark_circle)
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
                            margin: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  itemName,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),

                                Gaps.gapH10,

                                // hotOrIced, 사이즈, 컵 옵션
                                Row(
                                  children: [
                                    Text(hotOrIced),
                                    const Text(' | '),
                                    Text(drinkSize),
                                    const Text(' | '),
                                    Text(cup)
                                  ],
                                ),

                                //// 옵션 사항
                                // 에스프레소
                                espressoOption != 2 ? Text('$espressoOption') : const SizedBox(height: 0,),
                                // 시럽
                                syrupOption != "" ? Text(syrupOption) : const SizedBox(height: 0,),
                                // 휘핑 크림
                                whippedCreamOption != "" ? Text(whippedCreamOption) : const SizedBox(height: 0,),
                                // 얼음
                                iceOption != "" ? Text('얼음 $iceOption') : const SizedBox(height: 0,),

                                Gaps.gapH20,

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
                                          margin: const EdgeInsets.only(left: 20, right: 20),
                                          child: Text('$quantity'),
                                        ),

                                        GestureDetector(
                                          onTap: (){
                                            quantity++;
                                            setQuantity(itemId, quantity, double.parse(itemPrice));
                                          },
                                          child: const Icon(CupertinoIcons.plus_circle),
                                        ),

                                      ],
                                    ),

                                    Gaps.gapW50,

                                    Text(Strings.intlMessageAndArgs('currency', totalPrice))
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
        }
        return const Center(child: CircularProgressIndicator());
      }
    );
  }
}

