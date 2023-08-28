import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:oasis_cafe_app/screens/signUp.dart';
import 'package:oasis_cafe_app/strings/strings.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

      body: Center(
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
              child: TextField(
                decoration: InputDecoration(
                  hintText: Strings.email
                ),
              ),
            ),

            SizedBox(height: 10,),

            // password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                decoration: InputDecoration(
                    hintText: Strings.password
                ),
              ),
            ),

            SizedBox(height: 30,),

            // 로그인 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: (){
                  Navigator.push(
                    (context),
                    MaterialPageRoute(builder: (context) => BottomNavi())
                  );
                },

                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Palette.buttonColor1,
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
    );
  }
}
