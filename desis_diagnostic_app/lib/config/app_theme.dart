import 'package:flutter/material.dart';

class AppTheme {
  ThemeData theme(){
    return ThemeData(
      useMaterial3: false,
      colorSchemeSeed: Color.fromRGBO(24, 59, 255, 0.902)
    );
  }
}