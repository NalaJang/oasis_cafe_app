import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('CartPage'),
      ),

      body: CartItems(),

    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final itemProvider = Provider.of<ItemProvider>(context);
    final String userUid = userStateProvider.userUid;

    return FutureBuilder(
      future: itemProvider.getItemsFromCart(userUid),
      builder: (context, snapshot) {
        return ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.grey,
          ),

          itemCount: itemProvider.cartItems.length,
          itemBuilder: (context, index) {
            String itemName = itemProvider.cartItems[index].itemName;
            String itemPrice = itemProvider.cartItems[index].itemPrice;
            String drinkSize = itemProvider.cartItems[index].drinkSize;
            String cup = itemProvider.cartItems[index].cup;
            int espressoOption = itemProvider.cartItems[index].espressoOption;
            String hotOrIced = itemProvider.cartItems[index].hotOrIced;
            String syrupOption = itemProvider.cartItems[index].syrupOption;
            String whippedCreamOption = itemProvider.cartItems[index].whippedCreamOption;
            String iceOption = itemProvider.cartItems[index].iceOption;

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
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
                                  onTap: (){},
                                  child: Icon(CupertinoIcons.minus_circle),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: Text('1'),
                                ),

                                GestureDetector(
                                  onTap: (){},
                                  child: Icon(CupertinoIcons.plus_circle),
                                ),

                              ],
                            ),

                            SizedBox(width: 50,),

                            Text('NZD $itemPrice'),
                          ],
                        ),
                      ],
                    ),
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

