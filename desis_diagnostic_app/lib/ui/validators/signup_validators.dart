/// Clase para validación de datos de entrada.
/// Contiene validaciones específicas para correos electrónicos y nombres de usuario.

class Validators {
  /// Este metodo usa una expresión regular para verificar que el formato del correo electrónico
  /// sea válido.
  /// Devuelve `true` si el correo electrónico es válido, de lo contrario, `false`.
  static bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }

  /// Este metodo usa una expresión regular para verificar que el nombre contenga solo letras
  /// (incluyendo letras acentuadas y caracteres especiales como 'ñ') y espacios.
  /// Devuelve `true` si el nombre es válido, de lo contrario, `false`.
  static bool isValidName(String name) {
    final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
    return regex.hasMatch(name);
  }
}
