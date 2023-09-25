import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/menuDetailProvider.dart';
import 'package:oasis_cafe_app/provider/personalOptionProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/menuList_first.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/itemOption.dart';
import 'package:oasis_cafe_app/screens/mainMenus/order/menuList_second.dart';
import 'package:oasis_cafe_app/strings/strings.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (context) => MenuDetailProvider()),
        ChangeNotifierProvider(create: (context) => PersonalOptionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Login(),

        routes: {
          Strings.menuListFirst : (context) => const MenuListFirst(),

          // MenuListFirst -> MenuListSecond
          Strings.menuListSecond : (context) => const MenuListSecond(),

          // MenuListSecond -> ItemOption
          Strings.itemOption : (context) => const ItemOption()
        },
      ),
    );
  }
}

