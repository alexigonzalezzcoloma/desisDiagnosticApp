///Esta clase es un modelo de datos para los usuarios de la aplicación
///
class User {
  final String name;
  final String email;
  final DateTime birthDate;
  final String address;
  final String password;

  /// Se crea una nueva instancia del usuario.
  User({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.address,
    required this.password,
  });

/// Este metodo devuelve un mapa con las claves correspondientes a los atributos del usuario
/// es util para convertirlo en un formato adecuado para la transmisión o almacenamiento.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'address': address,
      'password': password,
    };
  }
}
