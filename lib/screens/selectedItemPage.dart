import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/model/model_item.dart';

import '../strings/strings.dart';

class SelectedItemPage extends StatefulWidget {
  const SelectedItemPage({Key? key}) : super(key: key);

  @override
  State<SelectedItemPage> createState() => _SelectedItemPageState();
}

class _SelectedItemPageState extends State<SelectedItemPage> {
  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)!.settings.arguments as List<ItemModel>;
    String itemId = argument[0].id;
    String itemName = argument[0].subTitle;
    String itemDescription = argument[0].description;
    String itemPrice = argument[0].price;

    return Scaffold(

      // 주문 버튼
      bottomNavigationBar: OrderButton(itemId: itemId, itemName: itemName,),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,

            // appBar 배경 이미지 추가
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                'image/IMG_mocha_hot.jpg',
                // 이미지 꽉 채우기
                fit: BoxFit.cover,
              ),
            ),
          ),


          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // 메뉴 설명
                  ItemDescription(
                    itemName: itemName,
                    itemDescription: itemDescription,
                    itemPrice: itemPrice,
                  ),

                  SizedBox(height: 30,),

                  // hot, iced button
                  HotNIcedButton(),

                  Divider(height: 50, thickness: 1,),

                  // 제품 영양 정보, 알레르기 유발 요인
                  ItemInfo()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({required this.itemId, required this.itemName, Key? key}) : super(key: key);

  final String itemId;
  final String itemName;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/selectedItemOptionPage',
        arguments: [
          widget.itemId,
          widget.itemName
        ]);
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
    );
  }
}

class ItemDescription extends StatelessWidget {
  const ItemDescription({Key? key,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice
    }) : super(key: key);

  final String itemName;
  final String itemDescription;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 메뉴명
        Text(
          itemName,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 15,),

        // 메뉴 설명
        SizedBox(
          // 메뉴 설명의 글이 짧아지자 텍스트가 중앙으로 모여졌다.
          // 그래서 텍스트 위젯이 화면 가로 전체를 차지하도록 설정
          width: double.infinity,
          child: Text(
            itemDescription,
            style: TextStyle(
              fontSize: 15
            ),
          )
        ),

        SizedBox(height: 15,),

        // 메뉴 가격
        Text(
          itemPrice,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}


class HotNIcedButton extends StatefulWidget {
  const HotNIcedButton({Key? key}) : super(key: key);

  @override
  State<HotNIcedButton> createState() => _HotNIcedButtonState();
}

class _HotNIcedButtonState extends State<HotNIcedButton> {

  bool isSelectedHOT = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        // 뜨거운 음료
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedHOT = true;
              });
            },

            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
              color: isSelectedHOT == true ? Palette.buttonColor1 : Colors.white,
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                      bottomLeft: Radius.circular(38.0)
                  )
              ),

              child: Text(
                Strings.hot,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelectedHOT == true ? Colors.white : Colors.black,
                  fontWeight: isSelectedHOT == true ? FontWeight.bold : FontWeight.normal
                ),
              ),
            ),
          ),
        ),

        // 차가운 음료
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedHOT = false;
              });
            },

            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: isSelectedHOT == true ? Colors.white : Palette.buttonColor1,
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(38.0),
                    bottomRight: Radius.circular(38.0)
                )
              ),

              child: Text(
                Strings.iced,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: isSelectedHOT == false ? Colors.white : Colors.black,
                    fontWeight: isSelectedHOT == false ? FontWeight.bold : FontWeight.normal
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ItemInfo extends StatelessWidget {
  const ItemInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          '제품 영양 정보',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        Divider(height: 50, thickness: 1,),

        Text(
          '알레르기 유발 요인',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

