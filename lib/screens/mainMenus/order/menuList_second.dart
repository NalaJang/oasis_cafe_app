import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/buttons.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/model/model_item.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:provider/provider.dart';

import '../../../strings/strings_en.dart';

class MenuListSecond extends StatefulWidget {
  const MenuListSecond({Key? key}) : super(key: key);

  @override
  State<MenuListSecond> createState() => _MenuListSecondState();
}

class _MenuListSecondState extends State<MenuListSecond> {

  late HotNIcedButton hotNIcedButton;
  bool isSelectedHot = true;


  @override
  void initState() {
    super.initState();

    hotNIcedButton = HotNIcedButton(setImage: imageChange,);
  }

  // 'hot', 'iced' 클릭 이벤트를 받아 이미지 변경
  void imageChange(bool value) {
    setState(() {
      isSelectedHot = value;
    });
  }


  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)!.settings.arguments as List<ItemModel>;
    String itemId = argument[0].id;
    String itemName = argument[0].subTitle;
    String itemDescription = argument[0].description;
    String itemPrice = argument[0].price;
    String collectionName = Provider.of<ItemProvider>(context, listen: false).getCollectionName;

    return Scaffold(

      // 주문 버튼
      bottomNavigationBar: DetailsButton(itemId: itemId, itemName: itemName, itemPrice: itemPrice,),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,

            // appBar 배경 이미지 추가
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                isSelectedHot ? 'image/IMG_mocha_hot.jpg' : 'image/IMG_mocha_iced.jpg',
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

                  if( collectionName == 'Espresso' )
                  const SizedBox(height: 10,),

                  // hot, iced button
                  if( collectionName == 'Espresso' )
                  HotNIcedButton(setImage: imageChange,),

                  const Divider(height: 50, thickness: 1,),

                  // 제품 영양 정보, 알레르기 유발 요인
                  const ItemInfo()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({required this.itemId, required this.itemName, required this.itemPrice, Key? key}) : super(key: key);

  final String itemId;
  final String itemName;
  final String itemPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
      child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, Strings.itemOption,
            arguments: [
              itemId,
              itemName,
              itemPrice
            ]);
        },
        style: Buttons().buttonColor1BgSubmitButton(),
        child: const Text(
          'Details',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white
          )
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
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 15,),

        // 메뉴 설명
        SizedBox(
          // 메뉴 설명의 글이 짧아지자 텍스트가 중앙으로 모여졌다.
          // 그래서 텍스트 위젯이 화면 가로 전체를 차지하도록 설정
          width: double.infinity,
          child: Text(
            itemDescription,
            style: const TextStyle(
              fontSize: 15
            ),
          )
        ),

        const SizedBox(height: 15,),

        // 메뉴 가격
        Text(
          itemPrice,
          style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
}

class HotNIcedButton extends StatefulWidget {
  const HotNIcedButton({required this.setImage, Key? key}) : super(key: key);

  final Function setImage;

  @override
  State<HotNIcedButton> createState() => _HotNIcedButtonState();
}

class _HotNIcedButtonState extends State<HotNIcedButton> {

  bool isSelectedHOT = true;

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
                widget.setImage(isSelectedHOT);
                Provider.of<PersonalOptionProvider>(context, listen: false).hotOrIcedOption = 'Hot';
              });
            },

            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
              color: isSelectedHOT == true ? Palette.buttonColor1 : Colors.white,
                  border: Border.all(color: Palette.buttonColor1, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                      bottomLeft: Radius.circular(38.0)
                  )
              ),

              child: Text(
                Strings.intlMessage('hot'),
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
                widget.setImage(isSelectedHOT);
                Provider.of<PersonalOptionProvider>(context, listen: false).hotOrIcedOption = 'Iced';
              });
            },

            child: Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: isSelectedHOT == true ? Colors.white : Palette.buttonColor1,
                border: Border.all(color: Palette.buttonColor1, width: 1),
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(38.0),
                    bottomRight: Radius.circular(38.0)
                )
              ),

              child: Text(
                Strings.intlMessage('iced'),
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

