import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/personalOption/selectedEspressoItem.dart';
import 'package:oasis_cafe_app/screens/personalOption/selectedFreshJuiceItem.dart';
import 'package:provider/provider.dart';

import '../config/palette.dart';
import '../provider/menuDetailProvider.dart';
import '../strings/strings.dart';


late DocumentSnapshot documentSnapshot;

class SelectedItemOptionPage extends StatelessWidget {
  const SelectedItemOptionPage({Key? key}) : super(key: key);

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

      bottomNavigationBar: SubmitButton(itemName: itemName,),
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

              const SizedBox(height: 15,),

              // 음료 사이즈 선택
              const DrinkSizeSelectionButton(),

              const SizedBox(height: 55,),

              const Text(
                '컵 선택',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 15,),

              // 컵 선택
              const CupSelectionButton(),

              const SizedBox(height: 55,),

              const Text(
                Strings.personalOption,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),

              const Divider(height: 25, thickness: 1,),

              // personal option list
              StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {

                  if( streamSnapshot.hasData ) {
                    documentSnapshot = streamSnapshot.data!.docs[0];

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

  bool isSelectedSmall = false;
  bool isSelectedMedium = false;
  bool isSelectedLarge = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // small
        GestureDetector(
          onTap: () {
            setState(() {
              isSelectedSmall = true;
              isSelectedMedium = false;
              isSelectedLarge = false;
            });
          },
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: isSelectedSmall ? Palette.buttonColor1 : Colors.white
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.coffee_outlined,
                  color: isSelectedSmall ? Colors.white : Colors.black,
                ),
                SizedBox(height: 11,),
                Text(
                  'Small',
                  style: TextStyle(
                      color: isSelectedSmall ? Colors.white : Colors.black
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  '237ml',
                  style: TextStyle(
                      color: isSelectedSmall ? Colors.white : Colors.black
                  ),
                ),
              ],
            )
          ),
        ),

        // medium
        GestureDetector(
          onTap: () {
            setState(() {
              isSelectedSmall = false;
              isSelectedMedium = true;
              isSelectedLarge = false;
            });
          },
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: isSelectedMedium ? Palette.buttonColor1 : Colors.white
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.coffee_outlined,
                  color: isSelectedMedium ? Colors.white : Colors.black,
                ),
                SizedBox(height: 11,),
                Text(
                  'Medium',
                  style: TextStyle(
                      color: isSelectedMedium ? Colors.white : Colors.black
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  '355ml',
                  style: TextStyle(
                      color: isSelectedMedium ? Colors.white : Colors.black
                  ),
                ),
              ],
            )
          ),
        ),

        // large
        GestureDetector(
          onTap: () {
            setState(() {
              isSelectedSmall = false;
              isSelectedMedium = false;
              isSelectedLarge = true;
            });
          },
          child: Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(10),
                color: isSelectedLarge ? Palette.buttonColor1 : Colors.white
            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.coffee_outlined,
                  color: isSelectedLarge ? Colors.white : Colors.black,
                ),
                SizedBox(height: 11,),
                Text(
                  'Large',
                  style: TextStyle(
                      color: isSelectedLarge ? Colors.white : Colors.black
                  ),
                ),
                SizedBox(height: 5,),
                Text(
                  '473ml',
                  style: TextStyle(
                      color: isSelectedLarge ? Colors.white : Colors.black
                  ),
                ),
              ],
            )
          ),
        )
      ],
    );
  }
}

class CupSelectionButton extends StatefulWidget {
  const CupSelectionButton({Key? key}) : super(key: key);

  @override
  State<CupSelectionButton> createState() => _CupSelectionButtonState();
}

class _CupSelectionButtonState extends State<CupSelectionButton> {

  bool isSelectedHaveHere = false;
  bool isSelectedKeepCup = false;
  bool isSelectedTakeaway = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        // 매장컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedHaveHere = true;
                isSelectedKeepCup = false;
                isSelectedTakeaway = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(38.0),
                      bottomLeft: Radius.circular(38.0)
                  ),
                color: isSelectedHaveHere? Palette.buttonColor1 : Colors.white
              ),

              child: Text(
                '매장컵',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelectedHaveHere? Colors.white : Colors.black
                ),
              ),
            ),
          ),
        ),

        // 개인컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedHaveHere = false;
                isSelectedKeepCup = true;
                isSelectedTakeaway = false;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                color: isSelectedKeepCup? Palette.buttonColor1 : Colors.white
              ),

              child: Text(
                '개인컵',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelectedKeepCup? Colors.white : Colors.black
                ),
              ),
            ),
          ),
        ),

        // 일회용컵
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelectedHaveHere = false;
                isSelectedKeepCup = false;
                isSelectedTakeaway = true;
              });
            },
            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0)
                  ),
                color: isSelectedTakeaway? Palette.buttonColor1 : Colors.white
              ),

              child: Text(
                '일회용컵',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: isSelectedTakeaway? Colors.white : Colors.black
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SubmitButton extends StatefulWidget {
  const SubmitButton({required this.itemName, Key? key}) : super(key: key);

  final String itemName;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final personalOptionProvider = Provider.of<PersonalOptionProvider>(context);

    return GestureDetector(
      onTap: (){
        var selectedShotOption = personalOptionProvider.selectedShotOption;
        var selectedSyrupOption = personalOptionProvider.selectedSyrupOption;
        var selectedWhippedCreamOption = personalOptionProvider.selectedWhippedCreamOption;

        userStateProvider.addItemsToCart(widget.itemName, selectedShotOption, selectedSyrupOption, selectedWhippedCreamOption);
      },

      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),

        decoration: BoxDecoration(
            color: Palette.buttonColor1,
            border: Border.all(color: Palette.buttonColor1, width: 1),
            borderRadius: BorderRadius.circular(25.0)
        ),

        child: const Text(
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

