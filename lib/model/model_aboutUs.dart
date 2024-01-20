import 'package:cloud_firestore/cloud_firestore.dart';

class AboutUsModel {

  String openingHoursId = '';
  String openAmPm = '';
  String openHour = '';
  String openMinutes = '';
  String closeAmPm = '';
  String closeHour = '';
  String closeMinutes = '';

  String phoneNumberId = '';
  String number1 = '';
  String number2 = '';
  String number3 = '';

  AboutUsModel.getOpeningHours(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    openingHoursId = snapshot.id;
    openAmPm = data['openAmPm'];
    openHour = data['openHour'];
    openMinutes = data['openMinutes'];
    closeAmPm = data['closeAmPm'];
    closeHour = data['closeHour'];
    closeMinutes = data['closeMinutes'];
  }

  AboutUsModel.getPhoneNumber(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    phoneNumberId = snapshot.id;
    number1 = data['number1'];
    number2 = data['number2'];
    number3 = data['number3'];
  }
}