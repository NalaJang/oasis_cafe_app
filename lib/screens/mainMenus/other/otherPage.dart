import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:provider/provider.dart';

const double sizedBoxWidth = 110.0;
const double sizedBoxHeight = 110.0;
final List<String> cardMenuRow = ['전자영수증', '개인정보 관리', '설정'];
final List<String> customerServiceMenuList = ['고객의 소리', '매장 정보', '내 리뷰'];
final List<IconData> customerServiceMenuIcon = [CupertinoIcons.speaker_2, CupertinoIcons.location_solid, Icons.edit_note];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Other',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),

        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(CupertinoIcons.bell)
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             // 카드 메뉴
             Row(
               children: [
                 Spacer(),
                 for( int i = 0; i < cardMenuRow.length; i++ )
                   CardMenuRow(i),
                 Spacer(),
               ],
             ),

            SizedBox(height: 35,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '고객지원',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 25,),

            // 고객 지원
            CustomerServiceMenu(),
            
            Text('${Provider.of<UserStateProvider>(context).userMobileNumber}')
          ],
        ),
      ),
    );
  }
}

class CardMenuRow extends StatelessWidget {
  const CardMenuRow(this.menuIndex, {Key? key}) : super(key: key);

  final int menuIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),

      child: SizedBox(
        width: sizedBoxWidth,
        height: sizedBoxHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 전자영수증
            if( menuIndex == 0 )
              Column(
                children: [
                  Icon(Icons.receipt_long_sharp),
                  SizedBox(height: 10,),
                  Text(cardMenuRow[0]),
                ],
              ),

            // 개인정보 관리
            if( menuIndex == 1)
              Column(
                children: [
                  Icon(Icons.person),
                  SizedBox(height: 10,),
                  Text(cardMenuRow[1]),
                ],
              ),

            // 설정
            if( menuIndex == 2)
              Column(
                children: [
                  Icon(Icons.settings),
                  SizedBox(height: 10,),
                  Text(cardMenuRow[2]),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class CustomerServiceMenu extends StatelessWidget {
  const CustomerServiceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 30),
        itemCount: customerServiceMenuList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 60,
            child: Row(
              children: [
                Icon(customerServiceMenuIcon[index]),
                SizedBox(width: 15,),
                Text(
                  customerServiceMenuList[index],
                  style: TextStyle(
                      fontSize: 19
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

