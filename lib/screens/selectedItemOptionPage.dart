import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/screens/personalOption/selectedEspressoItem.dart';
import 'package:oasis_cafe_app/screens/personalOption/selectedFreshJuiceItem.dart';
import 'package:provider/provider.dart';

import '../config/palette.dart';
import '../provider/menuDetailProvider.dart';
import '../strings/strings.dart';

class SelectedItemOptionPage extends StatefulWidget {
  const SelectedItemOptionPage({Key? key}) : super(key: key);

  @override
  State<SelectedItemOptionPage> createState() => _SelectedItemOptionPageState();
}

class _SelectedItemOptionPageState extends State<SelectedItemOptionPage> {

  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)!.settings.arguments as List;
    final String itemId = argument[0];
    final String itemName = argument[1];
    final menuDetailProvider = Provider.of<MenuDetailProvider>(context);
    String documentName = menuDetailProvider.getDocumentName;
    String collectionName = menuDetailProvider.getCollectionName;

    CollectionReference collectionReference =  FirebaseFirestore.instance
                                                  .collection(Strings.order)
                                                  .doc(documentName)
                                                  .collection(collectionName)
                                                  .doc(itemId)
                                                  .collection(Strings.ingredients);

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),

      bottomNavigationBar: SubmitButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.drinkSize,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 15,),

              // 음료 사이즈 선택
              DrinkSizeSelectionButton(),

              SizedBox(height: 55,),

              const Text(
                '컵 선택',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 15,),

              CupSelectionButton(),

              SizedBox(height: 55,),

              const Text(
                Strings.personalOption,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              Divider(height: 25, thickness: 1,),

              StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                  if( streamSnapshot.hasData ) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[0];

                    // 커피 퍼스널 옵션
                    if( collectionName == Strings.espresso ) {
                      return SelectedEspressoItem(
                        documentSnapshot: documentSnapshot,
                        itemName: itemName,
                      );

                      // 생과일 쥬스 퍼스널 옵션
                    } else if( collectionName == Strings.freshJuice ) {
                      return SelectedFreshJuiceItem(documentSnapshot: documentSnapshot);
                    }


                  }

                  return const Center(child: CircularProgressIndicator());
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DrinkSizeSelectionButton extends StatefulWidget {
  const DrinkSizeSelectionButton({Key? key}) : super(key: key);

  @override
  State<DrinkSizeSelectionButton> createState() => _DrinkSizeSelectionButtonState();
}

class _DrinkSizeSelectionButtonState extends State<DrinkSizeSelectionButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _setCupSizeButtonDesign('Short', '237'),
        _setCupSizeButtonDesign('Tall', '355'),
        _setCupSizeButtonDesign('Grande', '473'),
      ],
    );
  }

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

