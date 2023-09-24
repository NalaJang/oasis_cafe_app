import 'package:flutter/widgets.dart';

class PersonalOptionProvider with ChangeNotifier {
  String selectedDrinkSizeOption = '';
  String selectedCupOption = '';
  int selectedShotOption = 0;
  String selectedSyrupOption = '';
  String selectedWhippedCreamOption = '';
  String selectedIceOption = '';
}