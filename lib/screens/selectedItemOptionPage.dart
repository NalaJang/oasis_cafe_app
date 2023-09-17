import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/screens/personalOption/selectedEspressoItem.dart';
import 'package:oasis_cafe_app/screens/personalOption/personalOptionPage_syrup.dart';
import 'package:provider/provider.dart';

import '../provider/menuDetailProvider.dart';
import '../strings/strings.dart';

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _setCupSizeButtonDesign('Short', '237'),
                  _setCupSizeButtonDesign('Tall', '355'),
                  _setCupSizeButtonDesign('Grande', '473'),
                ],
              ),

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

                    if( itemId == Strings.espresso ) {
                      return SelectedEspressoItem(
                        documentSnapshot: documentSnapshot,
                        itemName: itemName,
                      );

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

