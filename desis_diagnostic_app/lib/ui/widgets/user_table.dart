import 'package:desis_diagnostic_app/api/models/user.model.dart';
import 'package:flutter/material.dart';

class UserTable extends StatelessWidget {
  final List<User> users;

  UserTable({required this.users});

  @override
  Widget build(BuildContext context) {
    return users.isEmpty
        ? Center(child: Text('No hay usuarios registrados'))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,  // Permite desplazamiento horizontal
            child: DataTable(
              columns: [
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Fecha de Nacimiento')),
              ],
              rows: users.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user.name)),
                  DataCell(Text(user.email)),
                  DataCell(Text(user.birthDate.toLocal().toString().split(' ')[0])),
                ]);
              }).toList(),
            ),
          );
  }
}

