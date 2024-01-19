import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/config/palette.dart';

class CustomerServiceMenu extends StatelessWidget {
  const CustomerServiceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> customerServiceMenuList = ['고객의 소리', '매장 정보', '내 리뷰'];
    List<IconData> customerServiceMenuIcon = [CupertinoIcons.speaker_2, CupertinoIcons.location_solid, Icons.edit_note];
    List<Widget> classNames = [AboutUs(), AboutUs(), AboutUs()];

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
                    if( index == 1 ) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => classNames[index]
                        )
                      );
                    }
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

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Oasis Cafe',
              style: TextStyle(
                color: Palette.textColor1,
                fontWeight: FontWeight.bold,
                fontSize: 17.0
              ),
            ),

            Row(
              children: [
                Icon(CupertinoIcons.clock),
                Container(
                  child: Row(
                    children: [
                      Text('월요일'),
                      Text('오전 11:30 ~ 오후 9시'),
                    ],
                  ),
                )
              ],
            ),

            Row(
              children: [
                Icon(Icons.phone),
                Text('00-000-0000')
              ],
            ),

            Row(
              children: [
                Icon(CupertinoIcons.location_solid),
                Text('서울')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
