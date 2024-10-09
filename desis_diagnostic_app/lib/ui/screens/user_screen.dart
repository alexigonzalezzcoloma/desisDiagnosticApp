import 'package:flutter/material.dart';
import '../../api/controllers/database.controller.dart';
import '../../api/models/user.model.dart';
import '../widgets/signup_form.dart';
import '../widgets/user_table.dart';


class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    List<User> users = await _databaseHelper.fetchUsers();
    setState(() {
      _users = users;
    });
  }

  void _addUser(String name, String email, String birthdate, String address, String password) async {
    User newUser = User(
      name: name,
      email: email,
      birthDate: DateTime.parse(birthdate),
      address: address,
      password: password, // Agregando el campo de contraseña
    );

    await _databaseHelper.insertUser(newUser);
    _fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuarios')),
      body: Column(
        children: [
          SignupForm(
            formKey: _formKey,
            onSubmit: (name, email, birthdate, address, password) {
              _addUser(name, email, birthdate, address, password); // Llamada a agregar usuario
            },
          ),
          Expanded(
            child: UserTable(users: _users), // Muestra la tabla de usuarios
          ),
        ],
      ),
    );
  }
}