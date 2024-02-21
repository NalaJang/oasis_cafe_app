import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../config/palette.dart';
import '../../../../provider/cartProvider.dart';
import '../../../../provider/userStateProvider.dart';
import '../../../../strings/strings_en.dart';

class OrderButton extends StatelessWidget {
  const OrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = const Color(0xffe8e8e8);
    final cartProvider = Provider.of<CartProvider>(context);
    bool hasCartData = cartProvider.hasCartData;

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
            offset: const Offset(3, 0)
          )
        ]
      ),

      child: GestureDetector(
        onTap: () async {
          await _pressedOrderButton(context, cartProvider, hasCartData);
        },

        child: Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),

          decoration: BoxDecoration(
            color: hasCartData == false ? Palette.buttonColor2 : Palette.buttonColor1,
            border: Border.all(
              color: hasCartData == false ? Palette.buttonColor2 : Palette.buttonColor1
            ),
            borderRadius: BorderRadius.circular(25.0),
          ),

          child: Text(
            Strings.intlMessage('orderButton'),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: hasCartData == false ? Colors.black45 : Colors.white
            ),
          ),
        ),
      ),
    );
  }

  _pressedOrderButton(BuildContext context, CartProvider cartProvider,bool hasCartData) async {
    String userUid = Provider.of<UserStateProvider>(context, listen: false).userUid;

    try {
      // 장바구니 내역에 없을 경우, 버튼 비활성화
      if( hasCartData == false ) {
        null;

      } else {
        // 주문 넣기
        var isOrdered = cartProvider.placeAnOrder(context, userUid);

        // 주문이 정상 처리됐을 경우
        if( await isOrdered ) {
          // 주문한 아이템 장바구니에서 삭제
          cartProvider.deleteAllItemsFromCart();

          ScaffoldMessenger.of((context)).showSnackBar(
            SnackBar(
              content: Text(Strings.intlMessage('orderCompleted'))
            )
          );
        }
      }

    } catch(e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString()
          )
        )
      );
    }
  }
}