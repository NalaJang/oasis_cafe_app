import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app/config/buttons.dart';
import 'package:oasis_cafe_app/config/commonTextStyle.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/signUp/signUp.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  var formKey = GlobalKey<FormState>();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();

  bool showSpinner = false;

  void _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
    }
  }

  InputDecoration _getDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue
        )
      )
    );
  }


  @override
  void dispose() {
    super.dispose();

    userEmailController.dispose();
    userPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.intlMessage('signIn')),
        centerTitle: true,
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(25),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        Intl.message('hello'),
                        style: CommonTextStyle.fontSize20,
                      ),

                      const Icon(
                        Icons.coffee,
                        size: 40,
                      ),
                    ],
                  ),

                  Gaps.gapH10,

                  Text(
                    Intl.message('oasisCafe'),
                    style: CommonTextStyle.fontSize20,
                  ),

                  Gaps.gapH50,

                  // email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: userEmailController,
                    autofocus: true,
                    // 다음 텍스트 필드로 포커스 이동
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                    value == '' ? Intl.message('emailValidation') : null,

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Intl.message('email')),
                  ),

                  Gaps.gapH20,

                  // password
                  TextFormField(
                    controller: userPasswordController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (val) async {
                      // 키보드에서 'done' 버튼을 눌렀을 때
                      await pressedLoginButton();
                    },

                    validator: (value) {
                      if( value == '' || value!.length < 6 ) {
                        return Intl.message('passwordValidation');

                      } else {
                        return null;
                      }
                    },

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Intl.message('password')),
                  ),

                  Gaps.gapH30,

                  // 로그인 버튼
                  GestureDetector(
                    onTap: () async {

                      await pressedLoginButton();
                    },

                    // sign in button
                    child: Buttons().edgeInsetsAll(20, 12, Intl.message('signIn'), 16),
                  ),

                  Gaps.gapH20,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Intl.message('forgottenPassword')
                      ),

                      Gaps.gapW10,
                      const Text(' | '),
                      Gaps.gapW10,

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUp())
                          );
                        },

                        child: Text(
                          Intl.message('createAnAccount')
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 로그인 버튼이 눌렸을 때, 유효성 확인
  Future<void> pressedLoginButton() async {
    _tryValidation();

    try {
      setState(() {
        showSpinner = true;
      });

      var isLogged = Provider
          .of<UserStateProvider>(context, listen: false)
          .signIn(
          userEmailController.text,
          userPasswordController.text
      );

      if( await isLogged ) {
        setState(() {
          showSpinner = false;
        });

        Navigator.pushAndRemoveUntil(
          (context),
          MaterialPageRoute(
              builder: (context) => const BottomNavi()
          ), (route) => false
        );
      }

    } catch (e) {
      debugPrint(e.toString());
      if( mounted ) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                e.toString()
            )
          )
        );

        setState(() {
          showSpinner = false;
        });
      }
    }
  }
}
