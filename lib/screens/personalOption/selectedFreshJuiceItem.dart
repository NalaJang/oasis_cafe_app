import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:provider/provider.dart';

import '../../strings/strings.dart';

class SelectedFreshJuiceItem extends StatefulWidget {
  const SelectedFreshJuiceItem({required this.documentSnapshot, Key? key}) : super(key: key);

  final documentSnapshot;

  @override
  State<SelectedFreshJuiceItem> createState() => _SelectedFreshJuiceItemState();
}

class _SelectedFreshJuiceItemState extends State<SelectedFreshJuiceItem> {

  var iceOption = ['None', 'Less', 'Regular'];
  var selectedIcoOption = [];

  String setSubTitleText() {
    if( selectedIcoOption.isEmpty ) {
      selectedIcoOption.add(iceOption[2]);
    }
    return selectedIcoOption[0];
  }

  Color setExpansionPanelBackgroundColor() {
    return const Color.fromARGB(250, 250, 250, 250);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        ExpansionPanelList.radio(
          elevation: 0,
          children: [
            ExpansionPanelRadio(
              value: 0,
              // header 를 클릭했을 때도 펼치고 접을 수 있도록 설정
              canTapOnHeader: true,
              backgroundColor: setExpansionPanelBackgroundColor(),
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: const Text(
                    '얼음',
                    style: TextStyle(
                      fontSize: 17
                    ),
                  ),

                  subtitle: Text(
                      setSubTitleText()
                  )
                );
              },

              body: Row(
                children: [
                  for( var i = 0; i < iceOption.length; i++ )
                  GestureDetector(

                    onTap: (){
                      selectedIcoOption.clear();
                      selectedIcoOption.add(iceOption[i]);
                      Provider.of<PersonalOptionProvider>(context, listen: false).selectedIceOption = iceOption[i];
                    },

                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(10),
                        color: selectedIcoOption.contains(iceOption[i]) ?
                                Palette.buttonColor1 : Colors.white
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          iceOption[i],
                          style: TextStyle(
                            color: selectedIcoOption.contains(iceOption[i]) ?
                                    Colors.white : Colors.grey
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            )
          ],
        )
        // Divider(height: 5, thickness: 1,),
      ],
    );
  }
}

