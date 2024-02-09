import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';

class HelloWidget extends StatelessWidget {
  const HelloWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 70),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Hello',
            style: TextStyle(
              fontSize: 35
            ),
          ),

          Gaps.gapW5,

          Icon(
            Icons.coffee,
            size: 40,
          ),
        ],
      ),
    );
  }
}
