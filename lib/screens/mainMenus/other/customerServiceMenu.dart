import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';

class CustomerServiceMenu extends StatelessWidget {
  const CustomerServiceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> customerServiceMenuList = ['고객의 소리', '매장 정보', '내 리뷰'];
    List<IconData> customerServiceMenuIcon = [CupertinoIcons.speaker_2, CupertinoIcons.location_solid, Icons.edit_note];

    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Column(
        children: [
          for( var index = 0; index < customerServiceMenuList.length; index++ )
            Row(
              children: [
                Icon(customerServiceMenuIcon[index]),
                Gaps.gapW15,

                TextButton(
                  onPressed: (){
                    print('index >> $index');
                  },
                  child: Text(
                    customerServiceMenuList[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19.0
                    ),
                  )
                )
              ],
            )
        ],
      ),
    );
  }
}

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('매장 정보'),
      ),

      body: Column(
        children: [
          Text('Oasis Cafe'),

          Row(
            children: [
              Text('매장 주소'),
              Text('서울')
            ],
          ),

          Text('영업 시간'),

          Row(
            children: [
              Text('전화번호'),
              Text('00-000-0000')
            ],
          ),
        ],
      ),
    );
  }
}
