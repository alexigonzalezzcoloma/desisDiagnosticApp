import 'package:flutter/material.dart';
import 'ui/screens/user_screen.dart';
import 'package:desis_diagnostic_app/config/app_theme.dart';

/// Función principal que se ejecuta al iniciar la aplicación.
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Usuario',
      theme: AppTheme().theme(), //Se llama a una clase especial que maneja el tema de la aplicación
      home: UserScreen(), // Define la pantalla principal de la aplicación, la cual se encuentra en un archivo separado y se invoca desde aquí.
    );
  }
}
