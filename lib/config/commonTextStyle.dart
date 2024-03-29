import 'package:flutter/material.dart';
import 'package:oasis_cafe_app/config/palette.dart';

class CommonTextStyle {
  static const fontSize15 = TextStyle(fontSize: 15.0);
  static const fontSize17 = TextStyle(fontSize: 17.0);
  static const fontSize20 = TextStyle(fontSize: 20.0);
  static const fontSize30 = TextStyle(fontSize: 30.0);
  static const fontBold = TextStyle(fontWeight: FontWeight.bold);

  static const textColorBrown = TextStyle(color: Colors.brown);
  static const fontBoldSize17TextColor1 = TextStyle(
                                        fontSize: 17.0,
                                        color: Palette.textColor1,
                                        fontWeight: FontWeight.bold
                                    );

  static whiteTextColor(double fontSize) => TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize
                                            );
}