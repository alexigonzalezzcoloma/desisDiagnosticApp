// models/user.dart
class User {
  final String name;
  final String email;
  final DateTime birthDate;
  final String address;
  final String password; // Agregar el campo de contraseña

  User({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.address,
    required this.password,
  });

  // Asegúrate de que tu método de conversión a Map incluya la contraseña
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'address': address,
      'password': password, // Agregar la contraseña
    };
  }
}
