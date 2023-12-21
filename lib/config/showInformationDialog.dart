import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/screens/login/login.dart';
import 'package:oasis_cafe_app/screens/mainMenus/main/mainPage.dart';
import 'package:oasis_cafe_app/screens/signUp/signUp.dart';
import 'package:provider/provider.dart';

import '../provider/userStateProvider.dart';

class ShowInformationDialog {



  void setShowLoginDialog(BuildContext context, bool isLogin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            isLogin ? '해당 서비스는 로그인 후에 이용하실 수 있습니다.' : '로그아웃 하시겠습니까?'),

          actions: [
            // 취소 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },

              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                side: const BorderSide(
                  color: Palette.buttonColor1,
                )
              ),

              child: const Text('닫기'),
            ),

            const SizedBox(width: 10,),

            // 확인 버튼
            ElevatedButton(
              onPressed: () {

                if( isLogin ) {
                  Navigator.push(
                      (context),
                      MaterialPageRoute(builder: (context) => const Login())
                  );

                // 로그아웃
                } else {
                  Provider.of<UserStateProvider>(context, listen: false)
                      .signOut();

                  // pushAndRemoveUntil : 이전 페이지들을 모두 제거하기 위한 메소드.
                  // true 를 반환할 때까지 이전 경로를 모두 제거한다.
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainPage()
                    ), (route) => false
                  );
                }

              },

              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Palette.buttonColor1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                ),
                side: const BorderSide(
                  color: Palette.buttonColor1,
                )
              ),

              child: Text(isLogin ? '로그인' : '로그아웃'),
            )
          ],
        );
      }
    );
  }


  // 로그인, 회원가입으로 유도하는 다이얼로그
  Future<void> showLoginSignUpDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10)
        )
      ),

      builder: (context) {
        double dialogHeight = MediaQuery.of(context).size.height * 0.4;
        return Container(
          height: dialogHeight,
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // 닫기
              GestureDetector(
                onTap: (){Navigator.of(context).pop();},
                child: const Icon(Icons.close)
              ),
              
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.coffee,
                      size: 40,
                    ),

                    const SizedBox(height: 20,),
                    const Text(
                      '로그인 후 이용이 가능합니다.',
                      style: TextStyle(
                        fontSize: 20
                      ),
                    ),

                    const SizedBox(height: 50,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 회원가입 버튼
                        signUpButton(context),

                        // 로그인 버튼
                        loginButton(context)
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  // 회원가입 버튼
  Widget signUpButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            (context),
            MaterialPageRoute(builder: (context) => const SignUp())
        );
      },
      child: buttonStyle('회원가입'),
    );
  }

  // 로그인 버튼
  Widget loginButton(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => const Login())
        );
      },
      child: buttonStyle('로그인')
    );
  }

  // 버튼 스타일
  Widget buttonStyle(String title) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      decoration: BoxDecoration(
          color: Palette.buttonColor1,
          border: Border.all(color: Palette.buttonColor1, width: 1),
          borderRadius: BorderRadius.circular(25.0)
      ),

      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white
        ),
      ),
    );
  }

}