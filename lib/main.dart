import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oasis_cafe_app/config/bottomNavi.dart';
import 'package:oasis_cafe_app/provider/aboutUsProvider.dart';
import 'package:oasis_cafe_app/provider/cartProvider.dart';
import 'package:oasis_cafe_app/provider/itemProvider.dart';
import 'package:oasis_cafe_app/provider/orderStateProvider.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:oasis_cafe_app/provider/transactionHistoryProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/menuList_first.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/itemOption.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/menuList_second.dart';
import 'package:oasis_cafe_app/strings/strings_en.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const MaterialColor white = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserStateProvider()),
        ChangeNotifierProvider(create: (context) => OrderStateProvider(Provider.of<UserStateProvider>(context, listen: false).userUid)),
        ChangeNotifierProvider(create: (context) => ItemProvider()),
        ChangeNotifierProvider(create: (context) => PersonalOptionProvider()),
        ChangeNotifierProvider(create: (context) => TransactionHistoryProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AboutUsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: BottomNavi(),

        routes: {
          Strings.menuListFirst : (context) => const MenuListFirst(),

          // MenuListFirst -> MenuListSecond
          Strings.menuListSecond : (context) => const MenuListSecond(),

          // MenuListSecond -> ItemOption
          Strings.itemOption : (context) => const ItemOption()
        },

        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],

        supportedLocales: const [
          Locale('en', ''),
          Locale('ko', ''),
        ],
      ),
    );
  }
}

