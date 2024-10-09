import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final void Function(String, String, String, String, String) onSubmit;

  SignupForm({required this.formKey, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(); 
    final TextEditingController emailController = TextEditingController();
    final TextEditingController birthdateController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nombre Completo'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese nombre completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Por favor ingrese email completo';
                }
                return null;
              },
            ),
            TextFormField(
              controller: birthdateController,
              decoration: const InputDecoration(labelText: 'Fecha de Nacimiento'),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null) {
                  birthdateController.text = pickedDate.toLocal().toString().split(' ')[0];
                }
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese fecha de nacimiento';
                }
                return null;
              },
            ),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(labelText: 'Dirección'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingrese dirección válida';
                }
                return null;
              },
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Por favor ingrese una contraseña de al menos 6 caracteres';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
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
              },
              child: const Text('Registrar'),
            ),
            const SizedBox(height: 10), // Espacio entre botones
            ElevatedButton(
              onPressed: () async {
                // Lógica para obtener datos desde la API
                await _fetchDataFromAPI(nameController, emailController, birthdateController, addressController);
              },
              child: const Text('Obtener desde API'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchDataFromAPI(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController birthdateController,
      TextEditingController addressController) async {
    try {
      // Reemplaza esta URL con la URL de tu API
      final response = await http.get(Uri.parse('https://api.example.com/user'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Suponiendo que la API devuelve un objeto con los campos 'name', 'email', 'birthdate', 'address'
        nameController.text = data['name'];
        emailController.text = data['email'];
        birthdateController.text = data['birthdate'];
        addressController.text = data['address'];
      } else {
        // Manejo de errores
        print('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}