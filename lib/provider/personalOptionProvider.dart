import 'package:flutter/widgets.dart';

class PersonalOptionProvider with ChangeNotifier {
  String selectedDrinkSizeOption = '';
  String selectedCupOption = '';
  String hotOrIcedOption = '';
  int selectedShotOption = 0;
  String selectedSyrupOption = '';
  String selectedWhippedCreamOption = '';
  String selectedIceOption = '';

  int vanillaSyrup = 0;
  int caramelSyrup = 0;

  // 시럽 양
  void changeSyrupAmount(String syrupName, bool isPlus) {

    if( syrupName == '바닐라 시럽' ) {
      if( isPlus ) {
        vanillaSyrup++;
      } else {
        vanillaSyrup--;
      }
      selectedSyrupOption = '$syrupName $vanillaSyrup';

    } else if( syrupName == '카라멜 시럽' ) {
      if( isPlus ) {
        caramelSyrup++;
      } else {
        caramelSyrup--;
      }
      selectedSyrupOption = '$syrupName $caramelSyrup';

    }

    notifyListeners();
  }
}