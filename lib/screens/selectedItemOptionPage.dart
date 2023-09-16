import 'package:cloud_firestore/cloud_firestore.dart';
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

    final argument = ModalRoute.of(context)!.settings.arguments as List;
    final String itemId = argument[0];
    final String itemName = argument[1];
    final menuDetailProvider = Provider.of<MenuDetailProvider>(context);
    String documentName = menuDetailProvider.getDocumentName;
    String collectionName = menuDetailProvider.getCollectionName;
    menuDetailProvider.setIngredientsCollectionReference(documentName, collectionName, itemId[0]);
    CollectionReference _collectionReference =  FirebaseFirestore.instance.collection('Order')
        .doc(documentName).collection(collectionName)
        .doc(itemId).collection('ingredients');

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
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

              SizedBox(height: 55,),

              Text(
                '퍼스널 옵션',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Divider(height: 25, thickness: 1,),

              StreamBuilder(
                stream: _collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                  if( streamSnapshot.hasData ) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[0];

                    return Column(
                      children: [
                        if( collectionName == 'Espresso' )

                          // 커피
                          ListTile(
                            title: Text(
                              '커피',
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

                        // 물
                        if( itemName == 'Americano' )
                          ListTile(
                            title: Text(
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
                        ListTile(
                          title: Text(
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
                    );

                  }

                  return Center(child: CircularProgressIndicator());
                }
              )

              // SizedBox(
              //   height: 400,
              //   child: FutureBuilder(
              //     future: menuDetailProvider.fetchIngredients(),
              //     builder: (context, snapshot) {
              //
              //     if( menuDetailProvider.ingredients.isEmpty ) {
              //       // print('menuDetailProvider.ingredients.isEmpty');
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //
              //       } else {
              //         return ListView.builder(
              //             itemCount: menuDetailProvider.ingredients.length,
              //             itemBuilder: (context, index) {
              //
              //               return Column(
              //                 children: [
              //                   Text('커피'),
              //                   Text(
              //                     '에스프레소 샷 ${menuDetailProvider.ingredients[index].espresso}',
              //                     style: TextStyle(
              //                       fontSize: 15
              //                     ),
              //                   )
              //                 ],
              //               );
              //               // return ListTile(
              //               //
              //               //   title: Padding(
              //               //     padding: const EdgeInsets.only(bottom: 5),
              //               //     child: Text(
              //               //       '커피',
              //               //       style: TextStyle(
              //               //         fontSize: 18,
              //               //       ),
              //               //     ),
              //               //   ),
              //               //   subtitle: Text(
              //               //     '에스프레소 샷 ${menuDetailProvider.ingredients[index].espresso}',
              //               //     style: TextStyle(
              //               //       fontSize: 15,
              //               //     ),
              //               //   ),
              //               //
              //               //   onTap: (){},
              //               // );
              //             }
              //         );
              //       }
              //     }
              //   ),
              // ),

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

