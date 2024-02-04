import 'dart:ui';

import 'package:flutter/material.dart';

class AllColor {
  static Color deepBlueColor = const Color(0xff243949);
  static Color blueColor = const Color(0xff517fa4);
  static Color blackColor = const Color(0xff434343);
  static Color deepBlackColor = const Color(0xff000000);
  static Color bgColor = const Color(0xff93a5cf);
  static Color whiteColor = const Color(0xffe4efe9); 
  static Color bg2Color = const Color(0xffe4efe9); 
}

class AllText {
 static text(String string, double d, FontWeight fontWeight, Color color) {
    return Text(string , style: TextStyle(
      fontSize:  d, 
      fontWeight: fontWeight, 
      color: color,
    ),);
  }
}
