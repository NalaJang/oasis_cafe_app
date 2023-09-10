import 'package:flutter/material.dart';

class SelectedItemPage extends StatefulWidget {
  const SelectedItemPage({Key? key}) : super(key: key);

  @override
  State<SelectedItemPage> createState() => _SelectedItemPageState();
}

class _SelectedItemPageState extends State<SelectedItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text('아이스 카페 모카'),
                        Text('Iced Caffe Mocha'),
                        Text('진한 초콜릿 모카 시럽과 풍부한 에스트레소를 신선한 우유 그리고 얼음과 섞어'),
                        Text('5,500원')
                      ],
                    ),
                  ),

                  HotNIcedButton()

                ],
              ),
            ),
          )
        ],
      ),
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
              padding: EdgeInsets.all(20.0),
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
              padding: EdgeInsets.all(20.0),
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

