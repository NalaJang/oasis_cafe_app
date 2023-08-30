import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/signUp.dart';
import 'package:oasis_cafe_app/strings/strings.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _authentication = FirebaseAuth.instance;
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
      focusedBorder: UnderlineInputBorder(
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
        // backgroundColor: Palette.backgroundColor,
        title: const Text(
          Strings.signIn,
          style: TextStyle(
            color: Palette.textColor1
          ),
        ),
      ),

      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.coffee,
                  size: 80,
                ),

                SizedBox(height: 30,),

                const Text(
                  Strings.hello,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),

                SizedBox(height: 10,),

                const Text(
                  Strings.welcome,
                  style: TextStyle(
                      fontSize: 20.0
                  ),
                ),

                SizedBox(height: 50,),

                // email
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: userEmailController,
                    validator: (value) =>
                    value == '' ? Strings.emailValidation : null,

                    cursorColor: Colors.black,
                    decoration: _getDecoration(Strings.email),
                  ),
                ),

                SizedBox(height: 20,),

                // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: userPasswordController,
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
                ),

                SizedBox(height: 30,),

                // 로그인 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () async {

                      _tryValidation();

                      try {
                        setState(() {
                          // showSpinner = true;
                        });

                        Provider.of<UserStateProvider>(context, listen: false).signIn(userEmailController.text, userPasswordController.text);

                        // final newUser =
                        //     await _authentication.signInWithEmailAndPassword(
                        //       email: userEmailController.text,
                        //       password: userPasswordController.text
                        //     );
                        //
                        // if( newUser.user != null ) {
                        //   setState(() {
                        //     showSpinner = false;
                        //   });
                        //
                          Navigator.push(
                            (context),
                            MaterialPageRoute(builder: (context) => BottomNavi())
                          );
                        // }
                        //
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         '로그인 성공',
                        //       ),
                        //     )
                        // );

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
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12)
                      ),

                      child: Center(
                        child: Text(
                          Strings.signIn,
                          style: TextStyle(
                            color: Palette.backgroundColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        Strings.forgottenPassword
                    ),

                    SizedBox(height: 10,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUp())
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
    );
  }
}
