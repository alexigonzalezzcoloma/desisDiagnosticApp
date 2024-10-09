import 'package:flutter/material.dart';
import '../../api/controllers/database.controller.dart';
import '../../api/models/user.model.dart';
import '../widgets/signup_form.dart';
import '../widgets/user_table.dart';

/// Pantalla principal para el registro de usuarios.
///
/// Esta pantalla importa 2 widget, uno para registrar nuevos usuarios y el otro para mostrarlos

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

/// Estado de la pantalla
class _UserScreenState extends State<UserScreen> {
  /// Clave global para el formulario de registro.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Controlador de la base de datos para manejar operaciones relacionadas con usuarios.
  final UserController _userController = UserController();

  /// Lista que almacena los usuarios registrados.
  List<User> _users = [];

  /// Inicializa el estado de la pantalla.
  ///
  /// Se llama al método _fetchUsers para obtener la lista de usuarios
  /// almacenados al iniciar la pantalla.
  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  /// Metodo que obtiene la lista de usuarios de la base de datos de forma asíncrona.
  Future<void> _fetchUsers() async {
    List<User> users = await _userController.fetchUsers();
    setState(() {
      _users = users;
    });
  }

  /// Metodo que permite agregar un nuevo usuario a la base de datos.
  void _addUser(String name, String email, String birthdate, String address,
      String password) async {
    User newUser = User(
      name: name,
      email: email,
      birthDate: DateTime.parse(birthdate),
      address: address,
      password: password,
    );

    await _userController.insertUser(newUser);
    _fetchUsers();
  }

  /// Construye la interfaz de usuario de la pantalla.
  ///
  /// Utiliza un Scaffold para crear la estructura básica,
  /// luego llama a un widget que contiene el formulario de registro de usuarios
  /// Y otro widget que contiene una tabla que muestra los usuarios.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Usuario')),// Barra de aplicación con título.
      body: Column(
        children: [
          SignupForm(
            //Llamada al widget con formulario
            formKey: _formKey,
            onSubmit: (name, email, birthdate, address, password) {
              // Se usa un evento OnSubmit para detectar cuando se reciben los datos del formulario.
              _addUser(name, email, birthdate, address,
                  password); // acá se llama al metodo que guarda el usuario
            },
          ),
          Expanded(
            child: UserTable(users: _users), // Llamada al widget con Tabla
          ),
        ],
      ),
    );
  }
}
