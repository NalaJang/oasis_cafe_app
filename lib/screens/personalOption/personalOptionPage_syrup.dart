import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

class PersonalOptionPage_syrup extends StatefulWidget {
  const PersonalOptionPage_syrup({Key? key}) : super(key: key);

  @override
  State<PersonalOptionPage_syrup> createState() => _PersonalOptionPage_syrupState();
}

class _PersonalOptionPage_syrupState extends State<PersonalOptionPage_syrup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 뒤로가기 화살표 제거
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('시럽',),
        actions: const [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Icon(Icons.close,),
          )
        ],
      ),

      bottomNavigationBar: SubmitButton(),

      body: SingleChildScrollView(
        child: Padding(
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
                        '모카 시럽',
                        style: TextStyle(fontSize: 17),
                      )
                  ),

                  Expanded(child: Text('')),

                  Expanded(
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
                          '3',
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
                ],
              ),

              SizedBox(height: 55,),
              Text('추가 옵션'),
              SizedBox(height: 15,),

              // 바닐라 시럽
              Row(
                children: [
                  Expanded(
                      child: Text(
                        '바닐라 시럽',
                        style: TextStyle(fontSize: 17),
                      )
                  ),

                  Expanded(child: Text('')),

                  Expanded(
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
                          '0',
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
                ],
              ),

              SizedBox(height: 45,),


              // 헤이즐넛 시럽
              Row(
                children: [
                  Expanded(
                      child: Text(
                        '헤이즐넛 시럽',
                        style: TextStyle(fontSize: 17),
                      )
                  ),

                  Expanded(child: Text('')),

                  Expanded(
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
                          '0',
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
                ],
              ),

              SizedBox(height: 45,),

              // 카라멜 시럽
              Row(
                children: [
                  Expanded(
                      child: Text(
                        '카라멜 시럽',
                        style: TextStyle(fontSize: 17),
                      )
                  ),

                  Expanded(child: Text('')),

                  Expanded(
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
                          '0',
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
                ],
              ),
            ],
          ),
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

