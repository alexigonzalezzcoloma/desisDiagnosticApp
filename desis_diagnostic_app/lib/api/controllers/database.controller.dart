import 'package:desis_diagnostic_app/api/models/user.model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Controlador para manejar las operaciones de la base de datos de usuarios.

class UserController {
  /// Instancia privada del controlador.
  static final UserController _instance = UserController._internal();

  /// Base de datos SQLite.
  static Database? _database;

  /// Factory para acceder a la instancia del controlador.
  factory UserController() {
    return _instance;
  }

  /// Constructor privado para la inicialización de la instancia.
  UserController._internal();

  /// Obtiene la base de datos, inicializándola si es necesario.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database =
        await _initDatabase(); // Inicializa la base de datos si no está disponible.
    return _database!;
  }

  /// Metodo que inicializa la base de datos SQLite.
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            email TEXT,
            birthDate TEXT,
            address TEXT,
            password TEXT
          )
          ''',
        );
      },
    );
  }

  /// Metodo que agrega un nuevo usuario en la base de datos.
  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Metodo que obtiene la lista de usuarios de la base de datos.
  Future<List<User>> fetchUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    // Convierte la lista de mapas a una lista de objetos User.
    return List.generate(maps.length, (i) {
      return User(
        name: maps[i]['name'],
        email: maps[i]['email'],
        birthDate: DateTime.parse(maps[i]['birthDate']),
        address: maps[i]['address'],
        password: maps[i]['password'],
      );
    });
  }
}
