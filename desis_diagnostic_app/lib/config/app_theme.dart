import 'package:flutter/material.dart';
/// Esta clase proporciona la configuración del tema para la aplicación.

class AppTheme {
    /// Devuelve una instancia de `ThemeData` configurada para la aplicación.

  ThemeData theme(){
    return ThemeData(
      useMaterial3: false,
      colorSchemeSeed: const Color.fromRGBO(24, 59, 255, 0.902) //se define un color para el esquema
    );
  }
}