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

