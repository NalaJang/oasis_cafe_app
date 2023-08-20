import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:oasis_cafe_app/screens/signUp.dart';

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
        title: Text(
          '로그인',
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

            Text(
              'Hello',
              style: TextStyle(
                fontSize: 20.0
              ),
            ),

            SizedBox(height: 10,),

            Text(
              'Welcome to OASIS CAFE',
              style: TextStyle(
                  fontSize: 20.0
              ),
            ),

            SizedBox(height: 50,),

            // email
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email'
                    ),
                  ),
              ),
            ),

            SizedBox(height: 10,),

            // password
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Container(
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
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
                      'Log in',
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
                    'forgotten password?'
                ),

                SizedBox(height: 10,),

                GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp())
                    );
                  },

                  child: Text(
                      'Create an account'
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
