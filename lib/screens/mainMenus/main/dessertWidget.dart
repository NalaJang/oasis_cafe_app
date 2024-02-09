import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';

class DessertWidget extends StatelessWidget {
  const DessertWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text(
              '하루가 달콤해지는 시간',
              style: TextStyle(
                fontSize: 25
              ),
            ),
          ],
        ),

        Gaps.gapH10,

        SizedBox(
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Image.asset('image/IMG_dessert1.PNG'),
              Gaps.gapW10,
              Image.asset('image/IMG_dessert2.PNG'),
              Gaps.gapW10,
              Image.asset('image/IMG_dessert1.PNG'),
              Gaps.gapW10,
              Image.asset('image/IMG_dessert2.PNG'),
              Gaps.gapW10,
              Image.asset('image/IMG_dessert1.PNG'),
              Gaps.gapW10,
              Image.asset('image/IMG_dessert2.PNG'),
            ],
          ),
        )
      ],
    );
  }
}
