import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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
        title: const Text(Strings.signIn),
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
                    children: const [
                      Text(
                        Strings.hello,
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),

                      Icon(
                        Icons.coffee,
                        size: 40,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10,),

                  const Text(
                    Strings.welcome,
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),

                  const SizedBox(height: 50,),

                  // email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: userEmailController,
                    autofocus: true,
                    // 다음 텍스트 필드로 포커스 이동
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                    value == '' ? Strings.emailValidation : null,

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Strings.email),
                  ),

                  const SizedBox(height: 20,),

                  // password
                  TextFormField(
                    controller: userPasswordController,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (val) async {

                      await pressedLoginButton();
                    },

                    validator: (value) {
                      if( value == '' || value!.length < 6 ) {
                        return Strings.passwordValidation;

                      } else {
                        return null;
                      }
                    },

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Strings.password),
                  ),

                  const SizedBox(height: 30,),

                  // 로그인 버튼
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () async {

                        await pressedLoginButton();
                      },

                      // sign in button
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Palette.buttonColor1,
                          borderRadius: BorderRadius.circular(12)
                        ),

                        child: const Center(
                          child: Text(
                            Strings.signIn,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          Strings.forgottenPassword
                      ),

                      const SizedBox(width: 10,),
                      const Text(' | '),
                      const SizedBox(width: 10,),

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignUp())
                          );
                        },

                        child: const Text(
                            Strings.createAnAccount
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

        Navigator.push(
          (context),
          MaterialPageRoute(builder: (context) => const BottomNavi())
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
