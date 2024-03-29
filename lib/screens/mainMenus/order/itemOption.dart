import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/commonDialog.dart';
import 'package:oasis_cafe_app/config/gaps.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/personalOption/selectedEspressoItem.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/personalOption/selectedFreshJuiceItem.dart';
import 'package:provider/provider.dart';

import '../../../config/palette.dart';
import '../../../provider/itemProvider.dart';
import '../../../strings/strings_en.dart';


late DocumentSnapshot documentSnapshot;

class ItemOption extends StatelessWidget {
  const ItemOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final argument = ModalRoute.of(context)!.settings.arguments as List;
    final String itemId = argument[0];
    final String itemName = argument[1];
    final String itemPrice = argument[2];
    final menuDetailProvider = Provider.of<ItemProvider>(context);
    String documentName = menuDetailProvider.getDocumentName;
    String collectionName = menuDetailProvider.getCollectionName;

    CollectionReference collectionReference =  FirebaseFirestore.instance
                                                  .collection(Strings.order)
                                                  .doc(documentName)
                                                  .collection(collectionName)
                                                  .doc(itemId)
                                                  .collection(Strings.ingredients);

    TextStyle setTitleTextStyle() {
      return const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),

      // 옵션 적용하기 버튼
      bottomNavigationBar: SubmitButton(itemName: itemName, itemPrice: itemPrice,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.intlMessage('drinkSize'),
                style: setTitleTextStyle(),
              ),

              Gaps.gapH15,

              // 음료 사이즈 선택
              const DrinkSizeSelectionButton(),

              Gaps.gapH50,

              Text(
                Strings.intlMessage('cupOption'),
                style: setTitleTextStyle(),
              ),

              Gaps.gapH15,

              // 컵 선택
              const CupSelectionButton(),

              Gaps.gapH50,

              Text(
                Strings.intlMessage('personalOption'),
                style: setTitleTextStyle()
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
                      return const SelectedFreshJuiceItem();
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

  var sizeOption = [Strings.intlMessage('small'), Strings.intlMessage('medium'), Strings.intlMessage('large')];
  var weightOption = ['237ml', '355ml', '473ml'];
  List<String> selectedSizeOption = [];


  @override
  void initState() {
    super.initState();

    // drink size, cup option 값 초기화
    selectedSizeOption.add(sizeOption[1]);
    Provider.of<PersonalOptionProvider>(context, listen: false).selectedDrinkSizeOption = 'Medium';
    Provider.of<PersonalOptionProvider>(context, listen: false).selectedCupOption = '';
  }

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
                  border: Border.all(
                      color: selectedSizeOption.contains(sizeOption[i]) ? Palette.buttonColor1 : Colors.grey),
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

  var cupOption = [Strings.intlMessage('haveHere'), Strings.intlMessage('keepCup'), Strings.intlMessage('togo')];
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
                  border: Border.all(
                      color: selectedCupOption.contains(cupOption[i]) ? Palette.buttonColor1 : Colors.grey),
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
  const SubmitButton({required this.itemName, required this.itemPrice, Key? key}) : super(key: key);

  final String itemName;
  final String itemPrice;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {

    final userStateProvider = Provider.of<UserStateProvider>(context);
    final menuDetailProvider = Provider.of<ItemProvider>(context);
    final personalOptionProvider = Provider.of<PersonalOptionProvider>(context);
    final userUid = userStateProvider.userUid;

    return GestureDetector(
      onTap: (){
        var selectedDrinkSizeOption = personalOptionProvider.selectedDrinkSizeOption;
        var selectedCupOption = personalOptionProvider.selectedCupOption;
        var hotOrIcedOption = personalOptionProvider.hotOrIcedOption;
        var selectedShotOption = personalOptionProvider.selectedShotOption;
        var selectedSyrupOption = personalOptionProvider.selectedSyrupOption;
        var selectedWhippedCreamOption = personalOptionProvider.selectedWhippedCreamOption;
        var selectedIceOption = personalOptionProvider.selectedIceOption;

        // 로그인 상태가 아닐 경우,
        if( userUid == '' ) {
          CommonDialog().showLoginSignUpDialog(context);

        } else {
          // 컵이 선택되지 않았을 경우
          if (selectedCupOption == '') {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(Strings.intlMessage('cupNotSelected'))
              )
            );
          } else {
            menuDetailProvider.addItemsToCart(
                userStateProvider.userUid,
                selectedDrinkSizeOption,
                selectedCupOption,
                hotOrIcedOption,
                widget.itemName,
                widget.itemPrice,
                selectedShotOption,
                selectedSyrupOption,
                selectedWhippedCreamOption,
                selectedIceOption
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(Strings.intlMessage('addCart'))
              )
            );
          }
        }
      },

      // 장바구니 담기 버튼
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),

        decoration: BoxDecoration(
            color: Palette.buttonColor1,
            border: Border.all(color: Palette.buttonColor1, width: 1),
            borderRadius: BorderRadius.circular(25.0)
        ),

        child: Text(
          Strings.intlMessage('submit'),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}

