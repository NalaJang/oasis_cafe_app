import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/accountTransactionHistory.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/personalInfo.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/settings.dart';
import 'package:provider/provider.dart';

import '../../../strings/strings_en.dart';

const double sizedBoxWidth = 110.0;
const double sizedBoxHeight = 110.0;
final List<String> cardMenuRow = [Strings.transactionHistory, Strings.personalInformation, Strings.settings];
final List<String> customerServiceMenuList = ['고객의 소리', '매장 정보', '내 리뷰'];
final List<IconData> customerServiceMenuIcon = [CupertinoIcons.speaker_2, CupertinoIcons.location_solid, Icons.edit_note];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var userName = Provider.of<UserStateProvider>(context, listen: false).userName;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          Strings.other,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
        ),

        actions: [
          // 알람 아이콘
          IconButton(
            onPressed: (){},
            icon: const Icon(CupertinoIcons.bell)
          )
        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // 환영 문구
            Text(
              '$userName님\n환영합니다! 🙌🏻',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),

            const SizedBox(height: 30,),

             // 전자영수증, 개인정보 관리, 설정
             Row(
               children: [
                 const Spacer(),
                 for( int i = 0; i < cardMenuRow.length; i++ )
                   CardMenuRow(i),
                 const Spacer(),
               ],
             ),

            const SizedBox(height: 35,),

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

            const SizedBox(height: 25,),

            // 고객 지원
            const CustomerServiceMenu(),

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
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AccountTransactionHistory())
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.receipt_long_sharp),
                    const SizedBox(height: 10,),
                    Text(cardMenuRow[0], textAlign: TextAlign.center,),
                  ],
                ),
              ),

            // 개인정보 관리
            if( menuIndex == 1)
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonalInfo())
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.person),
                    const SizedBox(height: 10,),
                    Text(cardMenuRow[1], textAlign: TextAlign.center),
                  ],
                ),
              ),

            // 설정
            if( menuIndex == 2)
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings())
                  );
                },

                child: Column(
                  children: [
                    const Icon(Icons.settings),
                    const SizedBox(height: 10,),
                    Text(cardMenuRow[2], textAlign: TextAlign.center),
                  ],
                ),
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
                const SizedBox(width: 15,),
                Text(
                  customerServiceMenuList[index],
                  style: const TextStyle(
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

