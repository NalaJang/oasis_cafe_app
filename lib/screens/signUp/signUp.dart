import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';
import 'package:provider/provider.dart';

import '../../provider/userStateProvider.dart';
import '../signIn/signIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool showSpinner = false;
  var formKey = GlobalKey<FormState>();
  final _authentication = FirebaseAuth.instance;

  var userNameController = TextEditingController();
  var userEmailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userMobileNumberController = TextEditingController();

  bool _checkAll = false;
  bool _isCheckedTermsOfUse = false;
  bool _isCheckedPrivacyPolicyAgreed = false;
  bool _isCheckedMarketingConsentAgreed = false;
  bool _isCheckBoxError = false;
  bool checkBoxError() {
    return _isCheckBoxError;
  }

  final double textFormSizedBoxHeight = 30.0;


  void _tryValidation() {
    final isValid = formKey.currentState!.validate();

    // 폼 스테이트 값이 유효하다면 값을 저장
    if( isValid) {
      formKey.currentState!.save();
    }
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

                  // 약관 전체 동의 및 해제
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        Strings.agreeToAllTermsConditions,
                        style: TextStyle(
                          fontSize: 15.0
                        ),
                      ),
                      Checkbox(
                        value: _checkAll,
                        checkColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            _checkAll = value!;
                            if( _checkAll ) {
                              _isCheckedTermsOfUse = true;
                              _isCheckedPrivacyPolicyAgreed = true;
                              _isCheckedMarketingConsentAgreed = true;
                            } else {
                              _isCheckedTermsOfUse = false;
                              _isCheckedPrivacyPolicyAgreed = false;
                              _isCheckedMarketingConsentAgreed = false;
                            }
                          });
                        }
                      )
                    ],
                  ),

                  // 이용약관 동의
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _setTermsAndConditionsDecoration(Strings.termsOfUseAgreed),
                      Checkbox(
                        value: _isCheckedTermsOfUse,
                        onChanged: (value) {
                          setState(() {
                            _isCheckedTermsOfUse = value!;
                          });
                        },
                        checkColor: Colors.blue,
                        side: MaterialStateBorderSide.resolveWith((states) =>
                        _isCheckBoxError == true ?
                            const BorderSide(width: 2.0, color: Colors.red) :
                            const BorderSide(width: 2.0, color: Colors.black54)
                        ),
                      ),
                    ],
                  ),

                  // 개인정보 수집 및 이용동의
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _setTermsAndConditionsDecoration(Strings.privacyPolicyAgreed),
                      Checkbox(
                        value: _isCheckedPrivacyPolicyAgreed,
                        onChanged: (value) {
                          setState(() {
                            _isCheckedPrivacyPolicyAgreed = value!;
                          });
                        },
                        checkColor: Colors.blue,
                        side: MaterialStateBorderSide.resolveWith((states) =>
                        _isCheckBoxError == true ?
                        const BorderSide(width: 2.0, color: Colors.red) :
                        const BorderSide(width: 2.0, color: Colors.black54)
                        ),
                      ),
                    ],
                  ),

                  // 광고성 정보 수신 동의
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _setMarketingConsentDecoration(),
                      Checkbox(
                        value: _isCheckedMarketingConsentAgreed,
                        onChanged: (value) {
                          setState(() {
                            _isCheckedMarketingConsentAgreed = value!;
                          });
                        },
                        checkColor: Colors.blue,
                      ),
                    ],
                  ),


                  SizedBox(height: textFormSizedBoxHeight,),

                  // 회원가입 버튼
                  _pressedSignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  // 회원가입 버튼
  Widget _pressedSignUpButton() {
    return GestureDetector(
      onTap: () async {

        // 사용자 입력 값 유효성 검사
        _tryValidation();

        if( _isCheckedTermsOfUse && _isCheckedPrivacyPolicyAgreed ) {
          _isCheckBoxError = false;
        } else {
          _isCheckBoxError = true;
        }

        setState(() {
          checkBoxError();
        });

        if( !checkBoxError() ) {

          try {
            setState(() {
              showSpinner = true;
            });

            var isSignedUp = Provider
                .of<UserStateProvider>(context, listen: false)
                .signUp(userEmailController.text, userPasswordController.text,
                userNameController.text, userMobileNumberController.text);

            if( await isSignedUp ) {
              setState(() {
                showSpinner = false;
              });

              if( mounted ) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        '회원가입이 완료되었습니다.',
                      ),
                    )
                );

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignIn()
                    ), (route) => false
                );
              }
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
        }
      },

      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Palette.buttonColor1,
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
    );
  }

  // textForm UI
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

  // 필수 약관 UI
  Row _setTermsAndConditionsDecoration(String policyName) {
    return Row(
      children: [
        const Text(
          Strings.required,
          style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
        ),
        const SizedBox(width: 5,),
        Text(
          policyName,
          style: const TextStyle(
              fontSize: 15.0
          ),
        ),
        const SizedBox(width: 10,),
        const Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
          size: 17.0,
        )
      ],
    );
  }

  // 광고성 정보 수신 동의 UI
  Row _setMarketingConsentDecoration() {
    return Row(
      children: const [
        Text(
          Strings.optional,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0
          ),
        ),
        SizedBox(width: 5,),
        Text(
          Strings.marketingConsentAgreed,
          style: TextStyle(
              fontSize: 15.0
          ),
        ),
        SizedBox(width: 10,),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.black54,
          size: 17.0,
        )
      ],
    );
  }
}
