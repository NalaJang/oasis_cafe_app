import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/commonTextStyle.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';

import '../screens/signIn/signIn.dart';
import '../screens/signUp/signUp.dart';
import 'buttons.dart';

class CommonDialog {

  var buttons = Buttons();


  showSnackBar(BuildContext context, String snackBarText) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarText,),
      )
    );
  }


  Future<bool> showConfirmDialog(BuildContext context, String content, String confirmButtonText) async {
    bool result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(content),

          actions: [
            // 취소 버튼
            _cancelButton(context),

            Gaps.gapW10,

            // 확인 버튼
            _confirmButton(context, confirmButtonText)
          ],
        );
      }
    );

    return result;
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

                    Gaps.gapH20,

                    Text(
                      Strings.intlMessage('availableAfterLoggingIn'),
                      style: CommonTextStyle.fontSize20,
                    ),

                    Gaps.gapH50,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 회원가입 버튼
                        buttons.pageRoute(context, const SignUp(), Strings.intlMessage('createAnAccount')),
                        // 로그인 버튼
                        buttons.pageRoute(context, const SignIn(), Strings.intlMessage('signIn')),
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

  // 계정 삭제
  Future<bool> showDeleteAccountDialog(BuildContext context) async {
    bool result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(Strings.intlMessage('deleteAccount')),
          content: Text(Strings.intlMessage('deleteAccountMessage')),

          actions: [
            // 확인 버튼
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },

              style: buttons.whiteBgButton(),

              child: Text(Strings.intlMessage('deleteAccount')),
            ),

            Gaps.gapW10,

            // 취소 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },

              style: buttons.buttonColor1BgDialogButton(),

              child: Text(Strings.intlMessage('cancel')),
            ),
          ],
        );
      }
    );

    return result;
  }


  // 취소 버튼
  Widget _cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(false);
      },

      style: buttons.whiteBgButton(),

      child: const Text('아니오'),
    );
  }


  // 확인 버튼
  Widget _confirmButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pop(true);
      },

      style: buttons.buttonColor1BgDialogButton(),

      child: Text(text),
    );
  }
}