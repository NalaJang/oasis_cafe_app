import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app/screens/login/login.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  var formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userMobileNumberController = TextEditingController();

  final double textFormSizedBoxHeight = 30.0;
  bool showSpinner = false;

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
          color: Colors.black54,
      ),
      border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.iconColor)
      ),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.iconColor)
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();

    userNameController.dispose();
    userEmailController.dispose();
    userPasswordController.dispose();
    userMobileNumberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.signUp
        ),
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  // 이름
                  TextFormField(
                      controller: userNameController,
                      validator: (value) =>
                      value == '' ? Strings.nameValidation : null,

                      cursorColor: Colors.black,
                      decoration: _getTextFormDecoration(Strings.name)

                  ),

                  SizedBox(height: textFormSizedBoxHeight,),

                  // 이메일
                  TextFormField(
                    controller: userEmailController,
                    validator: (value) =>
                    value == '' ? Strings.emailValidation : null,

                    cursorColor: Colors.black,
                    decoration: _getTextFormDecoration(Strings.email)

                  ),

                  SizedBox(height: textFormSizedBoxHeight,),

                  // 비밀번호
                  TextFormField(
                    controller: userPasswordController,
                    validator: (value) {
                      if( value == '' || value!.length < 6 ) {
                        return Strings.passwordValidation;

                      } else {
                        return null;
                      }
                    },

                    cursorColor: Colors.black,
                    decoration: _getTextFormDecoration(Strings.password),
                  ),

                  SizedBox(height: textFormSizedBoxHeight,),

                  // 비밀번호 확인
                  TextFormField(
                    validator: (value) {
                      if( value == '' || value != userPasswordController.text ) {
                        return Strings.confirmPasswordValidation;

                      } else {
                        return null;
                      }
                    },

                    cursorColor: Colors.black,
                    decoration: _getTextFormDecoration(Strings.confirmPassword),
                  ),

                  SizedBox(height: textFormSizedBoxHeight,),

                  // 휴대폰 번호
                  TextFormField(
                      controller: userMobileNumberController,
                      validator: (value) =>
                      value == '' ? Strings.mobileNumberValidation : null,

                      cursorColor: Colors.black,
                      decoration: _getTextFormDecoration(Strings.mobileNumber)

                  ),

                  SizedBox(height: textFormSizedBoxHeight,),

                  // 본인 인증 서비스
                  Text(''),


                  SizedBox(height: textFormSizedBoxHeight,),

                  // 회원가입 버튼
                  Container(
                    child: GestureDetector(
                      onTap: () async {

                        // 사용자 입력 값 유효성 검사
                        _tryValidation();

                        try {
                          setState(() {
                            showSpinner = true;
                          });

                          final newUser = await _authentication.createUserWithEmailAndPassword(
                              email: userEmailController.text, password: userPasswordController.text
                          );

                          await FirebaseFirestore.instance
                          .collection(Strings.collection_user)
                          .doc(newUser.user!.uid)
                          .set({
                            // 데이터의 형식은 항상 map 의 형태
                            'signUpTime' : DateTime.now(),
                            'userEmail' : userEmailController.text,
                            'userPassword' : userPasswordController.text,
                            'userName' : userNameController.text,
                            'userDateOfBirth' : '',
                            'userMobileNumber' : userMobileNumberController.text,
                            'notification' : false,
                            'shakeToPay' : false
                          });

                          if( newUser.user != null ) {
                            setState(() {
                              showSpinner = false;
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                    '회원가입이 완료되었습니다.',
                                  ),
                              )
                            );

                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Login())
                            );
                          }

                        } catch (e) {
                          print(e);
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
                      },

                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12.0)
                        ),

                        child: const Center(
                          child: Text(
                            Strings.signUp,
                              style: TextStyle(
                                color: Colors.white,
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
        ),
      ),
    );
  }
}
