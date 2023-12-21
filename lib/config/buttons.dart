import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

import '../screens/login/login.dart';
import '../screens/signUp/signUp.dart';


class Buttons {


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
  Widget buttonStyle(String buttonName) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      decoration: BoxDecoration(
          color: Palette.buttonColor1,
          border: Border.all(color: Palette.buttonColor1, width: 1),
          borderRadius: BorderRadius.circular(25.0)
      ),

      child: Text(
        buttonName,
        style: const TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  Widget whiteColorButtonStyle(String buttonName) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border.all(color: Palette.buttonColor1, width: 1),
          borderRadius: BorderRadius.circular(25.0)
      ),

      child: Text(
        buttonName,
        style: const TextStyle(
            color: Palette.buttonColor1
        ),
      ),
    );
  }
}