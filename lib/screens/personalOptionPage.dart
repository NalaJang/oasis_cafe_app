import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

class PersonalOptionPage extends StatefulWidget {
  const PersonalOptionPage({Key? key}) : super(key: key);

  @override
  State<PersonalOptionPage> createState() => _PersonalOptionPageState();
}

class _PersonalOptionPageState extends State<PersonalOptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 뒤로가기 화살표 제거
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('커피',),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.close,),
          )
        ],
      ),

      bottomNavigationBar: SubmitButton(),

      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('기본 옵션'),
            SizedBox(height: 15,),

            Row(
              children: [
                Expanded(
                    child: Text(
                      '에스프레소 샷',
                      style: TextStyle(fontSize: 17),
                    )
                ),

                Expanded(child: Text('')),

                Expanded(
                  child: Container(
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Image.asset(
                            'image/IMG_minimize.png',
                            scale: 7.8,
                          ),
                        ),

                        SizedBox(width: 20,),

                        Text(
                          '1',
                          style: TextStyle(fontSize: 17),
                        ),

                        SizedBox(width: 20,),

                        GestureDetector(
                          child: Image.asset(
                            'image/IMG_minimize.png',
                            scale: 7.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 55,),
            Text('추가 옵션'),
            SizedBox(height: 15,),
            Text('에스프레소 옵션', style: TextStyle(fontSize: 17),),
            SizedBox(height: 15,),

            Row(
              children: [
                GestureDetector(
                    onTap: (){},
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1)
                      ),

                      child: Text(
                          '디카페인'
                      ),
                    )
                )
              ],
            )

          ],
        ),
      )
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        print('submit');
      },

      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),

        decoration: BoxDecoration(
            color: Palette.buttonColor1,
          border: Border.all(color: Palette.buttonColor1, width: 1),
          borderRadius: BorderRadius.circular(25.0)
        ),

        child: Text(
          '적용하기',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}

