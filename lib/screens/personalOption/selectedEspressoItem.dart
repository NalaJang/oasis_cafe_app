import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

import '../../strings/strings.dart';

class SelectedEspressoItem extends StatelessWidget {
  const SelectedEspressoItem({required this.documentSnapshot, required this.itemName, Key? key}) : super(key: key);

  final documentSnapshot;
  final itemName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 커피
          ListTile(
            title: const Text(
              Strings.coffee,
              style: TextStyle(
                  fontSize: 17
              ),
            ),

            subtitle: Text(
                '에스프레소 샷 ${documentSnapshot['espresso']}'
            ),

            trailing: Icon(Icons.arrow_forward_ios),
          ),

        Divider(height: 5, thickness: 1,),

        // 시럽
        ListTile(
          title: Text(
            '시럽',
            style: TextStyle(
                fontSize: 17
            ),
          ),

          subtitle: Text(
              '${documentSnapshot['syrup']}'
          ),

          trailing: Icon(Icons.arrow_forward_ios),
        ),

        Divider(height: 5, thickness: 1,),

        if( itemName == 'Americano' )
          ListTile(
            title: const Text(
              '베이스',
              style: TextStyle(
                  fontSize: 17
              ),
            ),

            subtitle: Text(
                '${documentSnapshot['base']}'
            ),

            trailing: Icon(Icons.arrow_forward_ios),
          ),


        // 우유
        if( itemName != 'Americano' )
          Column(
            children: [

              ListTile(
                title: const Text(
                  '우유/음료 온도',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                subtitle: Text(
                    '${documentSnapshot['milk']}'
                ),

                trailing: Icon(Icons.arrow_forward_ios),
              ),

              Divider(height: 5, thickness: 1,),

              // 휘핑 크림
              ListTile(
                title: Text(
                  '휘핑 크림',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                trailing: Icon(Icons.arrow_forward_ios),
              ),

              Divider(height: 5, thickness: 1,),

              // 토핑
              ListTile(
                title: Text(
                  '토핑',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),

                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
      ],
    );
  }
}
