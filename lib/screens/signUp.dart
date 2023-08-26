import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userNameController = TextEditingController();
  var userBirthController = TextEditingController();
  var userPhoneNumberController = TextEditingController();

  void _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
    }
  }

  InputDecoration _getTextFormDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Colors.black,
      ),
      focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Palette.iconColor)
      ),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Palette.iconColor)
      ),
      errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Palette.iconColor)
      ),
      focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(color: Palette.iconColor)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign up'
        ),
      ),

      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              // 이메일
              TextFormField(
                controller: userEmailController,
                validator: (value) =>
                value == '' ? 'Please enter your email' : null,

                decoration: _getTextFormDecoration('이메일')

              ),

              SizedBox(height: 10,),

              // 비밀번호
              TextFormField(
                controller: userPasswordController,
                validator: (value) {
                  if( value == '' || value!.length < 6 ) {
                    return 'Please enter your password longer';

                  } else {
                    return null;
                  }
                },

                decoration: _getTextFormDecoration('비밀번호(6 ~ 20자리 이내)'),
              ),

              SizedBox(height: 10,),

              // 비밀번호 확인
              TextFormField(
                validator: (value) {
                  if( value == '' || value != userPasswordController.text ) {
                    return 'Please check your password';

                  } else {
                    return null;
                  }
                },

                decoration: _getTextFormDecoration('비밀번호 확인'),
              ),

              SizedBox(height: 10,),

              // 본인 인증 서비스
              Text(
                '본인 인증 서비스 약관 전체 동의\n'
                    '휴대폰 본인 인증 서비스 이용약관 동의(필수)'
              ),

              // 이름
              TextFormField(
                  controller: userNameController,
                  validator: (value) =>
                  value == '' ? 'Please enter your name' : null,

                  decoration: _getTextFormDecoration('이름')

              ),

              SizedBox(height: 10,),

              // 생년월일
              TextField(
                decoration: InputDecoration(
                    hintText: '생년월일 6자리'
                ),
              ),

              SizedBox(height: 10,),

              // 휴대폰 번호
              TextField(
                decoration: InputDecoration(
                    hintText: '휴대폰 번호'
                ),
              ),

              SizedBox(height: 30,),

              // 회원가입 버튼
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.buttonColor1,
                    borderRadius: BorderRadius.circular(12)
                  ),

                  child: GestureDetector(
                    onTap: (){
                      _tryValidation();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => BottomNavi())
                      // );
                    },

                    child: Center(
                      child: Text(
                        'Sign Up',
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontSize: 16,
                          )
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
