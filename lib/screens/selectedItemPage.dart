import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/model/model_item.dart';
import 'package:provider/provider.dart';

import '../provider/menuDetailProvider.dart';
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
    String selectedItemName = argument[0].subTitle;
    String itemDescription = argument[0].description;
    String itemPrice = argument[0].price;

    return Scaffold(
      // 주문 버튼
      bottomNavigationBar: OrderButton(),

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
                    selectedItemName: selectedItemName,
                    itemDescription: itemDescription,
                    itemPrice: itemPrice,
                  ),

                  SizedBox(height: 20,),

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
  const OrderButton({Key? key}) : super(key: key);

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/selectedItemOptionPage');
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
    required this.selectedItemName,
    required this.itemDescription,
    required this.itemPrice
    }) : super(key: key);

  final String selectedItemName;
  final String itemDescription;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          selectedItemName,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 10,),

        SizedBox(
          // 메뉴 설명의 글이 짧아지자 텍스트가 중앙으로 모여졌다.
          // 그래서 텍스트 위젯이 화면 가로 전체를 차지하도록 설정
          width: double.infinity,
          child: Text(itemDescription)
        ),

        SizedBox(height: 20,),

        Text(
          itemPrice,
          style: TextStyle(
              fontSize: 20,
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
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              print('tap');
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                      bottomLeft: Radius.circular(38.0)
                  )
              ),

              child: Text(
                'HOT',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        Expanded(
          child: GestureDetector(
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)
                  )
              ),

              child: Text(
                  'ICED',
                  textAlign: TextAlign.center
              ),
            ),

            onTap: (){},
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
      children: [
        Text(
          '제품 영양 정보',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        Divider(height: 50, thickness: 1,),

        Text(
          '알레르기 유발 요인',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

