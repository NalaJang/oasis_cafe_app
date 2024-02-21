import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';

import 'customerService/aboutUs.dart';

class CustomerServiceMenu extends StatelessWidget {
  const CustomerServiceMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> customerServiceMenuList = [
      Strings.intlMessage('customerFeedback'),
      Strings.intlMessage('storeInformation'),
      Strings.intlMessage('myReviews')
    ];
    List<IconData> customerServiceMenuIcon = [CupertinoIcons.speaker_2, CupertinoIcons.location_solid, Icons.edit_note];
    List<Widget> classNames = [AboutUs(), AboutUs(), AboutUs()];

    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Column(
        children: [
          for( var index = 0; index < customerServiceMenuList.length; index++ )
            Row(
              children: [
                Icon(customerServiceMenuIcon[index]),
                Gaps.gapW15,

                TextButton(
                  onPressed: (){
                    print('index >> $index');
                    if( index == 1 ) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => classNames[index]
                        )
                      );
                    }
                  },
                  child: Text(
                    customerServiceMenuList[index],
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19.0
                    ),
                  )
                )
              ],
            )
        ],
      ),
    );
  }
}
