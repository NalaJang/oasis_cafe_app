import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/screens/personalOption/personalOptionPage_coffee.dart';
import 'package:oasis_cafe_app/screens/personalOption/personalOptionPage_syrup.dart';
import 'package:provider/provider.dart';

import '../provider/menuDetailProvider.dart';

class SelectedItemOptionPage extends StatefulWidget {
  const SelectedItemOptionPage({Key? key}) : super(key: key);

  @override
  State<SelectedItemOptionPage> createState() => _SelectedItemOptionPageState();
}

class _SelectedItemOptionPageState extends State<SelectedItemOptionPage> {

  Container _setCupSizeButtonDesign(String name, String size) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10)
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.coffee_outlined),
          SizedBox(height: 11,),
          Text(name),
          SizedBox(height: 5,),
          Text('${size}ml'),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    final menuDetailProvider = Provider.of<MenuDetailProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('카페 모카'),
      ),

      body: SingleChildScrollView(
        child: Padding(
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

              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _setCupSizeButtonDesign('Short', '237'),
                  _setCupSizeButtonDesign('Tall', '355'),
                  _setCupSizeButtonDesign('Grande', '473'),
                ],
              ),

              SizedBox(height: 55,),

              Text(
                '컵 선택',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 15,),

              CupSelectionButton(),

              Divider(height: 70, thickness: 1,),

              Text(
                '퍼스널 옵션',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Divider(height: 30, thickness: 1,),

              FutureBuilder(
                future: menuDetailProvider.fetchIngredients(),
                builder: (context, snapshot) {

                  if( menuDetailProvider.ingredients.isEmpty ) {
                    print('menuDetailProvider.ingredients.isEmpty');
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  } else {
                    return ListView.builder(
                      itemCount: menuDetailProvider.ingredients.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${menuDetailProvider.ingredients[index]}'
                        );
                      }
                    );
                  }
                }
              ),

              // GestureDetector(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '커피',
              //         style: TextStyle(
              //             fontSize: 17
              //         ),
              //       ),
              //
              //       SizedBox(height: 5,),
              //
              //       Text(
              //         '에스프레소 샷 1',
              //         style: TextStyle(
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              //   onTap: (){
              //     showModalBottomSheet(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return PersonalOptionPage_coffee();
              //         }
              //     );
              //   },
              // ),
              //
              // Divider(height: 30, thickness: 1,),
              //
              // GestureDetector(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         '시럽',
              //         style: TextStyle(
              //             fontSize: 17
              //         ),
              //       ),
              //
              //       SizedBox(height: 5,),
              //
              //       Text(
              //         '모카 시럽 3',
              //         style: TextStyle(
              //           fontSize: 14,
              //         ),
              //       ),
              //     ],
              //   ),
              //   onTap: (){
              //     showModalBottomSheet(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return PersonalOptionPage_syrup();
              //         }
              //     );
              //   },
              // ),
            ],
          ),
        ),
      ),

        // child: SingleChildScrollView(
        //   child: Padding(
        //     padding: const EdgeInsets.all(20.0),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Text(
        //           '사이즈',
        //           style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold
        //           ),
        //         ),
        //
        //         SizedBox(height: 15,),
        //
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             _setCupSizeButtonDesign('Short', '237'),
        //             _setCupSizeButtonDesign('Tall', '355'),
        //             _setCupSizeButtonDesign('Grande', '473'),
        //           ],
        //         ),
        //
        //         SizedBox(height: 55,),
        //
        //         Text(
        //           '컵 선택',
        //           style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold
        //           ),
        //         ),
        //
        //         SizedBox(height: 15,),
        //
        //         CupSelectionButton(),
        //
        //         Divider(height: 70, thickness: 1,),
        //
        //         Text(
        //           '퍼스널 옵션',
        //           style: TextStyle(
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold
        //           ),
        //         ),
        //
        //         Divider(height: 30, thickness: 1,),
        //
        //         GestureDetector(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 '커피',
        //                 style: TextStyle(
        //                   fontSize: 17
        //                 ),
        //               ),
        //
        //               SizedBox(height: 5,),
        //
        //               Text(
        //                 '에스프레소 샷 1',
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           onTap: (){
        //             showModalBottomSheet(
        //               context: context,
        //               builder: (BuildContext context) {
        //                 return PersonalOptionPage_coffee();
        //               }
        //             );
        //           },
        //         ),
        //
        //         Divider(height: 30, thickness: 1,),
        //
        //         GestureDetector(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Text(
        //                 '시럽',
        //                 style: TextStyle(
        //                     fontSize: 17
        //                 ),
        //               ),
        //
        //               SizedBox(height: 5,),
        //
        //               Text(
        //                 '모카 시럽 3',
        //                 style: TextStyle(
        //                   fontSize: 14,
        //                 ),
        //               ),
        //             ],
        //           ),
        //           onTap: (){
        //             showModalBottomSheet(
        //                 context: context,
        //                 builder: (BuildContext context) {
        //                   return PersonalOptionPage_syrup();
        //                 }
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
    );
  }
}

class CupSelectionButton extends StatefulWidget {
  const CupSelectionButton({Key? key}) : super(key: key);

  @override
  State<CupSelectionButton> createState() => _CupSelectionButtonState();
}

class _CupSelectionButtonState extends State<CupSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // 매장컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              print('have here');
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                      bottomLeft: Radius.circular(38.0)
                  )
              ),

              child: Text(
                '매장컵',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        // 개인컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              print('keep cup');
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(38.0),
                  //     bottomLeft: Radius.circular(38.0)
                  // )
              ),

              child: Text(
                '개인컵',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),

        // 일회용컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              print('takeaway');
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)
                  )
              ),

              child: Text(
                '일회용컵',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

