import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

import '../../strings/strings.dart';

class SelectedFreshJuiceItem extends StatelessWidget {
  const SelectedFreshJuiceItem({required this.documentSnapshot, Key? key}) : super(key: key);

  final documentSnapshot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 커피
        ListTile(
          title: const Text(
            '얼음',
            style: TextStyle(
                fontSize: 17
            ),
          ),

          subtitle: Text(
              '${documentSnapshot['ice']}'
          ),

          trailing: Icon(Icons.arrow_forward_ios),
        ),

        Divider(height: 5, thickness: 1,),
      ],
    );
  }
}

