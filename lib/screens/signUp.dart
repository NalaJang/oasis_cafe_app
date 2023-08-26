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
                controller: userName,
                decoration: InputDecoration(
                  hintText: '이메일'
                ),
              ),

              SizedBox(height: 10,),

              // 비밀번호
              TextField(
                decoration: InputDecoration(
                    hintText: '비밀번호(6 ~ 20자리 이내)'
                ),
              ),

              SizedBox(height: 10,),

              // 비밀번호 확인
              TextField(
                decoration: InputDecoration(
                  hintText: '비밀번호 확인'
                ),
              ),

              SizedBox(height: 10,),

              // 본인 인증 서비스
              Text(
                '본인 인증 서비스 약관 전체 동의\n'
                    '휴대폰 본인 인증 서비스 이용약관 동의(필수)'
              ),

              // 이름
              TextField(
                decoration: InputDecoration(
                    hintText: '이름'
                ),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BottomNavi())
                      );
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
