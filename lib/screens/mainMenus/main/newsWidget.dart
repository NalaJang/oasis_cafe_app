import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Icon(
              Icons.mail_outline_sharp,
              size: 20,
            ),

            Gaps.gapW5,

            Text(
              "What's New",
              style: TextStyle(
                fontSize: 15
              ),
            )
          ],
        ),

        Gaps.gapH10,

        Column(
          children: [
            Image.asset(
              'image/IMG_banner1.PNG'
            ),

            Gaps.gapH10,

            Image.asset(
              'image/IMG_banner2.PNG'
            ),
          ],
        )
      ],
    );
  }
}
