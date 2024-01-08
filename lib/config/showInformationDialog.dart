import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/config/palette.dart';

import 'buttons.dart';

class ShowInformationDialog {

  var buttons = Buttons();


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
                        buttons.signUpButton(context),

                        // 로그인 버튼
                        buttons.loginButton(context)
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
  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Account'),
          content: const Text(
            'By deleting your Oasis account, '
                'all saved information will be lost. This action is irreversible. \n\n'
                'Would you like to proceed?'
          ),

          actions: [

            // 취소 버튼
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },

              child: buttons.buttonStyle('취소'),
            ),

            const SizedBox(width: 10,),

            // 확인 버튼
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },

              child: buttons.whiteColorButtonStyle('확인'),
            ),
          ],
        );
      }
    );
  }


  // 취소 버튼
  Widget _cancelButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pop(false);
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

      child: const Text('아니오'),
    );
  }

  // 확인 버튼
  Widget _confirmButton(BuildContext context, String text) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.of(context).pop(true);
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

      child: Text(text),
    );
  }
}