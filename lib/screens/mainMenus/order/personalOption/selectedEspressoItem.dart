import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:provider/provider.dart';

import '../../../../strings/strings.dart';
import '../itemOption.dart';

class SelectedEspressoItem extends StatefulWidget {
  const SelectedEspressoItem({required this.documentSnapshot, required this.itemName, Key? key}) : super(key: key);

  final DocumentSnapshot documentSnapshot;
  final String itemName;

  @override
  State<SelectedEspressoItem> createState() => _SelectedEspressoItemState();
}

class _SelectedEspressoItemState extends State<SelectedEspressoItem> {

  int shotOptionMinimumValue = 1;
  int syrupOptionMinimumValue = 0;
  int optionMaximumValue = 9;
  int shotOption = documentSnapshot['espresso'];
  String syrupOption = documentSnapshot['syrup'];
  int mochaSyrup = 0;
  // 휘핑 크림
  var whippedCreamOption = ['None', 'Less', 'Regular', 'Extra'];
  List<String> selectedWhippedCreamOption = [];

  Color setExpansionPanelBackgroundColor() {
    return const Color.fromARGB(250, 250, 250, 250);
  }

  TextStyle setListTitleTextStyle() {
    return const TextStyle(
        fontSize: 17
    );
  }

  @override
  void initState() {
    super.initState();

    Provider.of<PersonalOptionProvider>(context, listen: false).vanillaSyrup = 0;
    Provider.of<PersonalOptionProvider>(context, listen: false).caramelSyrup = 0;
    Provider.of<PersonalOptionProvider>(context, listen: false).selectedSyrupOption = '';
    Provider.of<PersonalOptionProvider>(context, listen: false).selectedWhippedCreamOption = '';
  }

  @override
  Widget build(BuildContext context) {

    final personalOptionProvider = Provider.of<PersonalOptionProvider>(context);
    personalOptionProvider.selectedShotOption = shotOption;

    return Column(
      children: [
        ExpansionPanelList.radio(
          elevation: 0,
          children: [
            ExpansionPanelRadio(
              // header 를 클릭했을 때도 펼치고 접을 수 있도록 설정
              canTapOnHeader: true,
              backgroundColor: setExpansionPanelBackgroundColor(),
              value: 0,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(
                    '커피',
                    style: setListTitleTextStyle(),
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
                                      if( shotOption > shotOptionMinimumValue ) {
                                        shotOption--;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.minus_circle,
                                    color: shotOption <= shotOptionMinimumValue ? Colors.grey : Colors.black,
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
                                      if( shotOption < optionMaximumValue ) {
                                        shotOption++;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    CupertinoIcons.plus_circle,
                                    color: shotOption >= optionMaximumValue ? Colors.grey : Colors.black,
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

            // 시럽
            ExpansionPanelRadio(
              // header 를 클릭했을 때도 펼치고 접을 수 있도록 설정
                canTapOnHeader: true,
                backgroundColor: setExpansionPanelBackgroundColor(),
                value: 1,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text(
                      '시럽',
                      style: setListTitleTextStyle(),
                    ),

                    subtitle: Container(
                      child: (() {
                        String selectedSyrup = syrupOption;
                        int vanillaSyrup = personalOptionProvider.vanillaSyrup;
                        int caramelSyrup = personalOptionProvider.caramelSyrup;

                        if( selectedSyrup == '0' ) {
                          selectedSyrup = '';

                        } else if( selectedSyrup != '0' ) {
                          if( vanillaSyrup > syrupOptionMinimumValue ||
                              caramelSyrup > syrupOptionMinimumValue ) {
                            selectedSyrup = '$syrupOption \n';
                          }
                        }

                        if( vanillaSyrup > syrupOptionMinimumValue ) {
                          selectedSyrup = '$selectedSyrup바닐라 시럽 $vanillaSyrup \n';
                        }
                        if( caramelSyrup > syrupOptionMinimumValue ) {
                          selectedSyrup = '$selectedSyrup카라멜 시럽 $caramelSyrup';
                        }

                        return Text(selectedSyrup);
                      }) (),
                    ),
                  );
                },

                body: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      // 바닐라 시럽
                      SyrupOptions(syrupName: '바닐라 시럽',),

                      SizedBox(height: 20,),

                      // 카라멜 시럽
                      SyrupOptions(syrupName: '카라멜 시럽',),

                      SizedBox(height: 30,),
                    ],
                  ),
                )
            ),

            // 베이스
            ExpansionPanelRadio(
              canTapOnHeader: true,
              backgroundColor: setExpansionPanelBackgroundColor(),
              value: 2,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: const Text(
                    '베이스',
                    style: TextStyle(
                        fontSize: 17
                    ),
                  ),

                  subtitle: Text(
                      '${widget.documentSnapshot['base']}'
                  ),

                );
              },

              body: Text('')
            ),

            // 휘핑 크림
            ExpansionPanelRadio(
                canTapOnHeader: true,
                backgroundColor: setExpansionPanelBackgroundColor(),
                value: 3,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: const Text(
                      '휘핑 크림',
                      style: TextStyle(
                          fontSize: 17
                      ),
                    ),

                    subtitle: selectedWhippedCreamOption.isEmpty ? Text('') : Text('${selectedWhippedCreamOption[0]}'),
                  );
                },

                body: Row(
                  children: [
                    for( var i = 0; i < whippedCreamOption.length; i++ )
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          selectedWhippedCreamOption.clear();
                          selectedWhippedCreamOption.add(whippedCreamOption[i]);
                          personalOptionProvider.selectedWhippedCreamOption = whippedCreamOption[i];
                        });
                      },

                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: selectedWhippedCreamOption.contains(whippedCreamOption[i]) ? Palette.buttonColor1 : Colors.white
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            whippedCreamOption[i],
                            style: TextStyle(
                              color: selectedWhippedCreamOption.contains(whippedCreamOption[i]) ? Colors.white : Colors.grey
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
          ],
        ),
      ],
    );
  }
}

class SyrupOptions extends StatefulWidget {
  const SyrupOptions({required this.syrupName, Key? key}) : super(key: key);

  final String syrupName;

  @override
  State<SyrupOptions> createState() => _SyrupOptionsState();
}

class _SyrupOptionsState extends State<SyrupOptions> {

  @override
  Widget build(BuildContext context) {

    int syrupAmount = 0;
    const int minimumValue = 0;
    const int maximumValue = 9;
    final personalOptionProvider = Provider.of<PersonalOptionProvider>(context);

    if( widget.syrupName == '바닐라 시럽' ) {
      syrupAmount = personalOptionProvider.vanillaSyrup;
    } else if( widget.syrupName == '카라멜 시럽' ) {
      syrupAmount = personalOptionProvider.caramelSyrup;
    }

    return Row(
      children: [
        Expanded(
            child: Text(
              widget.syrupName,
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

                      if( syrupAmount > minimumValue ) {
                        personalOptionProvider.changeSyrupAmount(widget.syrupName, false);
                      }

                    });
                  },
                  child: Icon(
                    CupertinoIcons.minus_circle,
                    color: syrupAmount <= minimumValue ? Colors.grey : Colors.black,
                  ),
                ),

                SizedBox(width: 20,),

                Text(
                    '$syrupAmount',
                    style: TextStyle(
                        fontSize: 15
                    )
                ),

                SizedBox(width: 20,),

                GestureDetector(
                  onTap: (){
                    setState(() {
                      if( syrupAmount < maximumValue ) {
                        personalOptionProvider.changeSyrupAmount(widget.syrupName, true);
                      }
                    });
                  },
                  child: Icon(
                    CupertinoIcons.plus_circle,
                    color: syrupAmount >= maximumValue ? Colors.grey : Colors.black,
                  ),
                )
              ],
            )
        ),
      ],
    );
  }
}
