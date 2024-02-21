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
import '../../signIn/signIn.dart';
import '../../signUp/signUp.dart';

const double sizedBoxWidth = 110.0;
const double sizedBoxHeight = 110.0;
final List<String> cardMenuRow = [
  Strings.intlMessage('transactionHistory'),
  Strings.intlMessage('personalInformation'),
  Strings.intlMessage('settings')
];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var userStateProvider = Provider.of<UserStateProvider>(context);
    var userName = userStateProvider.userName;

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

            Gaps.spacer,

            // 환영 문구
            Text(
              userName == '' ? Strings.intlMessage('welcome')
                  : Strings.intlMessageAndArgs('welcomeWithName', userName),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            Gaps.spacer,

            userName == '' ?
                // 로그인 상태가 아닐 때,
                // 회원가입, 로그인 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Buttons().pageRoute(context, const SignUp(), '회원가입'),
                    Buttons().pageRoute(context, const SignIn(), '로그인'),
                  ],
                ) :
               // 로그인 상태 일 때,
               // 전자영수증, 개인정보 관리, 설정
               Row(
                 children: [
                   Gaps.spacer,
                   for( int i = 0; i < cardMenuRow.length; i++ )
                     GestureDetector(child: CardMenuRow(i)),
                   Gaps.spacer,
                 ],
               ),

            const Spacer(flex: 2,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 25),
                  child: Text(
                    Strings.intlMessage('customerService'),
                    style: const TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),

            // 고객 지원
            const CustomerServiceMenu(),
            Gaps.spacer,

            // 로그아웃
            userName == '' ? Gaps.spacer : const SignOut(),
            Gaps.spacer,
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
    Widget? className;
    IconData? iconName;

    // 전자영수증
    if( menuIndex == 0 ) {
      className = const AccountTransactionHistory();
      iconName = Icons.receipt_long_sharp;
    }
    // 개인정보 관리
    else if( menuIndex == 1 ) {
      className = const PersonalInfo();
      iconName = Icons.person;
    }
    // 설정
    else if( menuIndex == 2 ) {
      className = const Settings();
      iconName = Icons.settings;
    }

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => className!)
        );
      },

      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),

        child: SizedBox(
            width: sizedBoxWidth,
            height: sizedBoxHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconName),
              Gaps.gapH10,
              Text(cardMenuRow[menuIndex], textAlign: TextAlign.center,),
            ],
          ),
        )
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

      child: Text(
        Strings.intlMessage('signOut'),
        style: const TextStyle(
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

