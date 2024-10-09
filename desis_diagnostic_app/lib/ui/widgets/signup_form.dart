import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../validators/signup_validators.dart'; // Importa la clase de validaciones

/// SignupForm es un widget que representa un formulario de registro de usuario.
/// Permite la entrada de los datos del usuario y la validación de estos
/// Ademas puede obtener datos aleatorios de un API para rellenar los campos
///
class SignupForm extends StatelessWidget {
  final GlobalKey<FormState>
      formKey; // Clave para el formulario, utilizada para validación.
  final void Function(String, String, String, String, String)
      onSubmit; // Callback para manejar el envío de datos.

  SignupForm({required this.formKey, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    // Controladores de texto para cada campo del formulario
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController birthdateController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey, // Asigna la clave del formulario para validación.
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextFormField(
              controller: birthdateController,
              decoration: const InputDecoration(labelText: 'Fecha Nacimiento'),
              readOnly: true,
              onTap: () async {
                // Selector de fecha al tocar sobre en el campo fecha
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  // Formato de la fecha seleccionada
                  birthdateController.text =
                      pickedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            ElevatedButton(
              // Botón para registrar el usuario
              onPressed: () {
                _validateAndSubmit(
                  context,
                  nameController,
                  emailController,
                  birthdateController,
                  addressController,
                  passwordController,
                );
              },
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              // Botón para obtener datos aleatorios desde una API
              onPressed: () async {
                await _fetchDataFromAPI(nameController, emailController,
                    birthdateController, addressController, passwordController);
              },
              child: const Text('Obtener desde API'),
            ),
          ],
        ),
      ),
    );
  }

  /// Método para obtener datos de un API y rellenar el formulario.
  Future<void> _fetchDataFromAPI(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController birthdateController,
      TextEditingController addressController,
      TextEditingController passwordController) async {
    try {
      final response = await http
          .get(Uri.parse('https://randomuser.me/api/')); // Llamada a la API

      if (response.statusCode == 200) {
        final data =
            json.decode(response.body); // Decodificación de la respuesta
        final user = data['results'][0];
        
        // Rellenar los campos del formulario con los datos obtenidos y adecuarlos al modelo de datos manejado

        nameController.text = '${user['name']['first']} ${user['name']['last']}';
        emailController.text = '${user['email']}';

        DateTime birthdate = DateTime.parse(user['dob']['date']);
        birthdateController.text = DateFormat('yyyy-MM-dd').format(birthdate);

        addressController.text ='${user['location']['street']['number']} ${user['location']['street']['name']}, ${user['location']['city']}, ${user['location']['country']}';
        passwordController.text = '${user['login']['password']}';
      } else {
        print('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

    /// Metodo que muestra un cuadro de diálogo con un mensaje de alerta.
  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  /// Metodo que valida los campos del formulario y llama a la función de envío si son válidos.

  void _validateAndSubmit(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController birthdateController,
      TextEditingController addressController,
      TextEditingController passwordController) {
    // Validaciones manuales
    if (nameController.text.isEmpty) {
      _showAlertDialog(
          context, 'Campo Obligatorio', 'El campo nombre es Obligatorio');
      return;
    }
    if (nameController.text.length < 6) {
      _showAlertDialog(context, 'Nombre Inválido',
          'El campo nombre es demasiado corto, favor ingresar nombre completo');
      return;
    }
    if (!Validators.isValidName(nameController.text)) {
      _showAlertDialog(context, 'Nombre Inválido',
          'El campo nombre tiene caractéres extraños, favor solo ingresar letras y espacios)');
      return;
    }
    if (emailController.text.isEmpty) {
      _showAlertDialog(context, 'Campo Obligatorio',
          'El campo Correo Electrónico es Obligatorio');
      return;
    }
    if (!Validators.isValidEmail(emailController.text)) {
      _showAlertDialog(context, 'Email Inválido',
          'Por favor ingrese un Correo Electrónico válido');
      return;
    }
    if (birthdateController.text.isEmpty) {
      _showAlertDialog(context, 'Campo Obligatorio',
          'El campo Fecha de Nacimiento es Obligatorio');
      return;
    }
    if (addressController.text.isEmpty) {
      _showAlertDialog(
          context, 'Campo Obligatorio', 'El campo Dirección es Obligatorio');
      return;
    }
    if (passwordController.text.isEmpty) {
      _showAlertDialog(
          context, 'Campo Obligatorio', 'El campo Contraseña es Obligatorio');
      return;
    }
    if (passwordController.text.length < 6) {
      _showAlertDialog(context, 'Contraseña Inválida',
          'Por favor ingrese una contraseña de al menos 6 caracteres');
      return;
    }

    // Si todo es válido enviar
    onSubmit(
      nameController.text,
      emailController.text,
      birthdateController.text,
      addressController.text,
      passwordController.text,
    );

    // Limpia los campos después de enviar
    nameController.clear();
    emailController.clear();
    birthdateController.clear();
    addressController.clear();
    passwordController.clear();
  }
}
