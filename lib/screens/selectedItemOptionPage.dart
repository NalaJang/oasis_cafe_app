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
    final String hotOrIced = argument[2];
    final menuDetailProvider = Provider.of<MenuDetailProvider>(context);
    String documentName = menuDetailProvider.getDocumentName;
    String collectionName = menuDetailProvider.getCollectionName;

    CollectionReference collectionReference =  FirebaseFirestore.instance
                                                  .collection(Strings.order)
                                                  .doc(documentName)
                                                  .collection(collectionName)
                                                  .doc(itemId)
                                                  .collection(Strings.ingredients);

    final personalOptionProvider = Provider.of<PersonalOptionProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),

      // 옵션 적용하기 버튼
      bottomNavigationBar: SubmitButton(itemName: itemName, hotOrIced: hotOrIced,),

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

  var sizeOption = ['Small', 'Medium', 'Large'];
  var weightOption = ['237ml', '355ml', '473ml'];
  List<String> selectedSizeOption = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        for( var i = 0; i < sizeOption.length; i++ )
        GestureDetector(
          onTap: () {
            setState(() {
              selectedSizeOption.clear();
              selectedSizeOption.add(sizeOption[i]);
              Provider.of<PersonalOptionProvider>(context, listen: false).selectedDrinkSizeOption = sizeOption[i];
            });
          },
          child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(10),
                  color: selectedSizeOption.contains(sizeOption[i]) ?
                          Palette.buttonColor1 : Colors.white
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.coffee_outlined,
                    color: selectedSizeOption.contains(sizeOption[i]) ?
                            Colors.white : Colors.black,
                  ),

                  SizedBox(height: 11,),

                  Text(
                    sizeOption[i],
                    style: TextStyle(
                        color: selectedSizeOption.contains(sizeOption[i]) ?
                                Colors.white : Colors.black
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    weightOption[i],
                    style: TextStyle(
                        color: selectedSizeOption.contains(sizeOption[i]) ?
                                Colors.white : Colors.black
                    ),
                  ),
                ],
              )
          ),
        ),
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

  var cupOption = ['매장컵', '개인컵', '일회용컵'];
  var selectedCupOption = [];

  BorderRadius? setBorderRadius(int i) {
    if( i == 0 ) {
      return const BorderRadius.only(
          topLeft: Radius.circular(38.0),
          bottomLeft: Radius.circular(38.0)
      );

    } else if( i == 2 ) {
      return const BorderRadius.only(
        topRight: Radius.circular(38.0),
        bottomRight: Radius.circular(38.0)
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        for( var i = 0; i < cupOption.length; i++ )
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedCupOption.clear();
                selectedCupOption.add(cupOption[i]);
                Provider.of<PersonalOptionProvider>(context, listen: false).selectedCupOption = cupOption[i];
              });
            },

            child: Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: setBorderRadius(i),
                  color: selectedCupOption.contains(cupOption[i]) ? Palette.buttonColor1 : Colors.white
              ),

              child: Text(
                cupOption[i],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: selectedCupOption.contains(cupOption[i]) ? Colors.white : Colors.black
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
  const SubmitButton({required this.itemName, required this.hotOrIced, Key? key}) : super(key: key);

  final String itemName;
  final String hotOrIced;

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
        var selectedDrinkSizeOption = personalOptionProvider.selectedDrinkSizeOption;
        var selectedCupOption = personalOptionProvider.selectedCupOption;
        var selectedShotOption = personalOptionProvider.selectedShotOption;
        var selectedSyrupOption = personalOptionProvider.selectedSyrupOption;
        var selectedWhippedCreamOption = personalOptionProvider.selectedWhippedCreamOption;
        var selectedIceOption = personalOptionProvider.selectedIceOption;

        userStateProvider.addItemsToCart(
          selectedDrinkSizeOption,
          selectedCupOption,
          widget.hotOrIced,
          widget.itemName,
          selectedShotOption,
          selectedSyrupOption,
          selectedWhippedCreamOption,
          selectedIceOption
        );
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

