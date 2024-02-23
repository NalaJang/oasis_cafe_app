import 'package:intl/intl.dart';

class Strings {

  static String intlMessage(String messageText) => Intl.message(messageText);
  static String intlMessageAndArgs(String messageText, Object args) =>
      Intl.message(messageText, args: [args]);

  static const String menuListFirst = '/menuListFirst';
  static const String menuListSecond = '/menuListSecond';
  static const String itemOption = '/itemOption';

  static const String collection_user = 'user';
  static const String collection_userOrder = 'user_order';
  static const String collection_userCart = 'user_cart';
  static const String collection_ingredients = 'ingredients';

  static const String order = 'Order';
  static const String beverage = 'Beverage';
  static const String food = 'Food';
  static const String espresso = 'Espresso';
  static const String freshJuice = 'Fresh juice';
  static const String ingredients = 'ingredients';
}