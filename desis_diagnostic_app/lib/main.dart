import 'package:flutter/material.dart';
import 'ui/screens/user_screen.dart';
import 'package:desis_diagnostic_app/config/app_theme.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registro de Usuario',
      theme: AppTheme().theme(),
      home: UserScreen(),
    );
  }
}
