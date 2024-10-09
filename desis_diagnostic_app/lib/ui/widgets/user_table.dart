import 'package:desis_diagnostic_app/api/models/user.model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de tener esta importación

/// UserTable es un widget que muestra una tabla de usuarios
/// en un formato de tabla de datos (DataTable). Permite el
/// desplazamiento horizontal y vertical, y asegura que el contenido
/// de cada celda no se desborde, sino que sea desplazable.

class UserTable extends StatelessWidget {
  final List<User> users;

  UserTable({required this.users});

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? Center(child: Text('No hay usuarios registrados')) // Mensaje si no hay usuarios.
        : SingleChildScrollView(
            scrollDirection: Axis.vertical, // Permite desplazamiento vertical
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Permite desplazamiento horizontal
              child: DataTable(
                columnSpacing: 16.0, // Espaciado entre columnas
                dataRowHeight: 60.0, // Altura de las filas
                columns: [
                  DataColumn(label: Text('Nombre')), // Columna para el nombre.
                  DataColumn(label: Text('Correo')), // Columna para el email.
                  DataColumn(label: Text('Fecha Nacimiento')), // Columna para la fecha de nacimiento.
                ],
                rows: users.map((user) {
                  return DataRow(cells: [
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Desplazamiento horizontal dentro de la celda
                        child: Text(user.name),
                      ),
                    ),
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Desplazamiento horizontal dentro de la celda
                        child: Text(user.email),
                      ),
                    ),
                    DataCell(
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Desplazamiento horizontal dentro de la celda
                        child: Text(DateFormat('dd/MM/yyyy').format(user.birthDate.toLocal())), // Fecha de nacimiento en formato chileno.

                      ),
                    ),
                  ]);
                }).toList(), // Convierte la lista de usuarios en filas de la tabla.
              ),
            ),
          );
  }
}
