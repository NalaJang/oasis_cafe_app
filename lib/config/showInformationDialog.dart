import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/screens/login/login.dart';
import 'package:oasis_cafe_app/screens/signUp/signUp.dart';

class ShowInformationDialog {

  Future<void> showLoginDialog(BuildContext context) {
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
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              (context),
                              MaterialPageRoute(builder: (context) => const SignUp())
                            );
                          },
                          child: buttonStyle('회원가입'),
                        ),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              (context),
                              MaterialPageRoute(builder: (context) => const Login())
                            );
                          },
                          child: buttonStyle('로그인')
                        )
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