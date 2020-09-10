import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextStyles {
  static TextStyle titleStyle({Color color, double size}) {
    return GoogleFonts.amaticaSc().copyWith(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.bold,
//      shadows: [
//        Shadow(
//          blurRadius: 5.0,
//          color: Colors.black,
//          offset: Offset(2.0, 2.0),
//        ),
//      ],
    );
  }
}
