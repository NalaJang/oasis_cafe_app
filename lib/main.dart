import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/provider/menuDetailProvider.dart';
import 'package:oasis_cafe_app/provider/userStateProvider.dart';
import 'package:oasis_cafe_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:oasis_cafe_app/screens/menuDetail.dart';
import 'package:oasis_cafe_app/screens/selectedItemOptionPage.dart';
import 'package:oasis_cafe_app/screens/selectedItemPage.dart';
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
        ChangeNotifierProvider(create: (context) => MenuDetailProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: white,
        ),
        home: Login(),

        routes: {
          '/menuDetail' : (context) => const MenuDetailPage(),
          // MenuDetailPage -> SelectedItemPage
          '/selectedItem' : (context) => const SelectedItemPage(),
          // SelectedItemPage -> SelectedItemOptionPage
          '/selectedItemOptionPage' : (context) => const SelectedItemOptionPage()
        },
      ),
    );
  }
}

