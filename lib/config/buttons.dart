import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';


class Buttons {


  Widget pageRoute(BuildContext context, Widget className, String buttonName) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            (context),
            MaterialPageRoute(builder: (context) => className)
        );
      },
      child: buttonStyle(buttonName),
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


  ButtonStyle whiteBgButton() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      side: const BorderSide(
        color: Palette.buttonColor1,
      )
    );
  }

  ButtonStyle buttonColor1BgSubmitButton() {
    return ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(15.0),
        foregroundColor: Colors.white,
        backgroundColor: Palette.buttonColor1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25)
        ),
        side: const BorderSide(
          color: Palette.buttonColor1,
        )
    );
  }

  ButtonStyle buttonColor1BgDialogButton() {
    return ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      backgroundColor: Palette.buttonColor1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18)
      ),
      side: const BorderSide(
        color: Palette.buttonColor1,
      )
    );
  }
}