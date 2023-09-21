import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

import '../../strings/strings.dart';
import '../selectedItemOptionPage.dart';

class SelectedEspressoItem extends StatefulWidget {
  const SelectedEspressoItem({required this.documentSnapshot, required this.itemName, Key? key}) : super(key: key);

  final DocumentSnapshot documentSnapshot;
  final String itemName;

  @override
  State<SelectedEspressoItem> createState() => _SelectedEspressoItemState();
}

class _SelectedEspressoItemState extends State<SelectedEspressoItem> {

  int shotOption = documentSnapshot['espresso'];

  Color setBackgroundColor() {
    return const Color.fromARGB(250, 250, 250, 250);
  }

  TextStyle setTitleTextStyle() {
    return const TextStyle(
        fontSize: 17
    );
  }

  @override
  Widget build(BuildContext context) {
    // int shotOption = widget.documentSnapshot['espresso'];

    return Column(
      children: [
        ExpansionPanelList.radio(
          elevation: 0,
          children: [
            ExpansionPanelRadio(
              // header 를 클릭했을 때도 펼치고 접을 수 있도록 설정
              canTapOnHeader: true,
              backgroundColor: setBackgroundColor(),
              value: 0,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    '커피',
                    style: setTitleTextStyle(),
                  ),

                  subtitle: Text(
                    '에스프레소 샷 $shotOption',
                  ),
                );
              },

                body: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            '디카페인',
                          ),
                        ),
                      ),

                      SizedBox(height: 30,),

                      Row(
                        children: [
                          Expanded(
                              child: Text(
                              '에스프레소 샷',
                              style: TextStyle(
                                fontSize: 15
                              ),
                            )
                          ),
                          Expanded(child: Text('')),
                          Expanded(
                              child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      if( shotOption > 1 ) {
                                        shotOption--;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.minus_circle,
                                    color: shotOption < 2 ? Colors.grey : Colors.black,
                                  ),
                                ),

                                SizedBox(width: 20,),

                                Text(
                                  '$shotOption',
                                  style: TextStyle(
                                      fontSize: 15
                                  )
                                ),

                                SizedBox(width: 20,),

                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      if( shotOption < 8 ) {
                                        shotOption++;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.plus_circle,
                                    color: shotOption > 7 ? Colors.grey : Colors.black,
                                  ),
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                    ],
                  ),
                )
            ),

          ],
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
              '${widget.documentSnapshot['syrup']}'
          ),

          trailing: Icon(Icons.arrow_forward_ios),
        ),

        Divider(height: 5, thickness: 1,),

        ListTile(
          title: const Text(
            '베이스',
            style: TextStyle(
                fontSize: 17
            ),
          ),

          subtitle: Text(
              '${widget.documentSnapshot['base']}'
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
    );
  }
}