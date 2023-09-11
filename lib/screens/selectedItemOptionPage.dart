import 'package:flutter/material.dart';

class SelectedItemOptionPage extends StatefulWidget {
  const SelectedItemOptionPage({Key? key}) : super(key: key);

  @override
  State<SelectedItemOptionPage> createState() => _SelectedItemOptionPageState();
}

class _SelectedItemOptionPageState extends State<SelectedItemOptionPage> {

  Container _setCupSizeButtonDesign(String name, String size) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(10)
        ),

        child: Padding(
          padding: const EdgeInsets.only(top: 18, bottom: 18, left: 15, right: 15),
          child: Column(
            children: [
              Icon(Icons.coffee_outlined),
              SizedBox(height: 11,),
              Text(name),
              SizedBox(height: 5,),
              Text('${size}ml'),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('카페 모카'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '사이즈',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(height: 10,),

            Row(
              children: [
                _setCupSizeButtonDesign('Short', '237'),
                _setCupSizeButtonDesign('Tall', '355'),
                _setCupSizeButtonDesign('Grande', '473'),
              ],
            ),

            SizedBox(height: 30,),

            Text(
              '컵 선택',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
