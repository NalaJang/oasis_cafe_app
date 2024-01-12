import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/config/commonDialog.dart';
import 'package:oasis_cafe_app/main.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/accountTransactionHistory.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/customerServiceMenu.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/personalInfo.dart';
import 'package:oasis_cafe_app/screens/mainMenus/other/settings.dart';
import 'package:provider/provider.dart';

import '../../../config/buttons.dart';
import '../../../strings/strings_en.dart';

const double sizedBoxWidth = 110.0;
const double sizedBoxHeight = 110.0;
final List<String> cardMenuRow = [Strings.transactionHistory, Strings.personalInformation, Strings.settings];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var userName;
    var userStateProvider = Provider.of<UserStateProvider>(context);
    if( userStateProvider.userUid == '' ) {
      userName = '';
    } else {
      userName = userStateProvider.userName;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          Strings.other,
          style: TextStyle(fontSize: 30,),
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

            const Spacer(),

            // 환영 문구
            Text(
              userName == '' ? '환영합니다! 🙌🏻' : '$userName님\n환영합니다! 🙌🏻',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            const Spacer(),

            // 로그인 상태가 아닐 때,
            userName == '' ?
                // 회원가입, 로그인 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons().signUpButton(context),
                    Buttons().loginButton(context),
                  ],
                ) :
               // 전자영수증, 개인정보 관리, 설정
               Row(
                 children: [
                   const Spacer(),
                   for( int i = 0; i < cardMenuRow.length; i++ )
                     CardMenuRow(i),
                   const Spacer(),
                 ],
               ),

            const Spacer(flex: 2,),

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
                SizedBox(height: 25,),
              ],
            ),

            // 고객 지원
            const CustomerServiceMenu(),
            const Spacer(),

            // 로그아웃
            userName == '' ? const Spacer() : const SignOut(),
            const Spacer(),
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
                    Gaps.gapH10,
                    Text(cardMenuRow[0], textAlign: TextAlign.center,),
                  ],
                ),
              ),

            // 개인정보 관리
            if( menuIndex == 1 )
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PersonalInfo())
                  );
                },
                child: Column(
                  children: [
                    const Icon(Icons.person),
                    Gaps.gapH10,
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
                    Gaps.gapH10,
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



// 로그아웃
class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pressedSignOutButton(context);
      },

      child: const Text(
        'Sign out',
        style: TextStyle(
          color: Colors.black54,
          fontSize: 15.0,
          decoration: TextDecoration.underline
        ),
      ),
    );
  }

  _pressedSignOutButton(BuildContext context) async {
    var isSignOut =  CommonDialog().showConfirmDialog(context, '로그아웃 하시겠습니까?', '로그아웃');

    if( await isSignOut ) {
      try {
        var isSignOut = Provider.of<UserStateProvider>((context), listen: false).signOut();

        if( await isSignOut ) {
          // pushAndRemoveUntil : 이전 페이지들을 모두 제거하기 위한 메소드.
          // true 를 반환할 때까지 이전 경로를 모두 제거한다.
          Navigator.pushAndRemoveUntil(
            (context),
            MaterialPageRoute(
              builder: (context) => const MyApp()
            ), (route) => false
          );
        }

      } catch(e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of((context)).showSnackBar(
          SnackBar(
            content: Text(
              e.toString()
            )
          )
        );
      }
    }
  }
}

