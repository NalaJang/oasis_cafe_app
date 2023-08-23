import 'package:flutter/material.dart';

final List<String> entries = ['추천', '에스프레소', '생과일 쥬스'];
final List<String> subheading = ['Recommend', 'Espresso', 'Fresh juice'];

class Beverage extends StatelessWidget {
  const Beverage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Image.asset(
                'image/IMG_espresso.png',
                height: 80,
              ),

              SizedBox(width: 20,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entries[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 3,),

                  Text(
                    subheading[index],
                    style: TextStyle(
                      fontWeight: FontWeight.w200
                    ),
                  )
                ],
              )
            ],
          )
        );
      }
    );
  }
}
