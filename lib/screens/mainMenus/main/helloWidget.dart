import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.intlMessage('hello'),
            style: const TextStyle(
              fontSize: 35
            ),
          ),

          Gaps.gapW5,

          const Icon(
            Icons.coffee,
            size: 40,
          ),
        ],
      ),
    );
  }
}
