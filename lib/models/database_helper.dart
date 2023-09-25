import 'package:agros/models/agros.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider instance = DatabaseProvider._init();
  static Database? _database;

  DatabaseProvider._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('my_database.db');

    final count = Sqflite.firstIntValue(
        await _database!.rawQuery('SELECT COUNT(*) FROM users'));
    if (count == 0) {
      await _insertInitialUser(_database!);
    }

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        data TEXT NOT NULL,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        profile TEXT NOT NULL
      )
    ''');

    await db.execute('''
    CREATE TABLE agros (
      id INTEGER PRIMARY KEY,
      nombre TEXT NOT NULL,
      precio REAL NOT NULL,
      tipo TEXT NOT NULL,
      imagenPath TEXT NOT NULL
    )
  ''');
  }

  Future<void> _insertInitialUser(Database db) async {
    await db.insert(
      'users',
      {
        'id': 1,
        'data': 'Mayerli Castañeda',
        'username': 'mayerli123',
        'password': '123456',
        'profile': 'admin',
      },
    );
  }

  Future<int> insertAnimal(Agros animal) async {
    final db = await database;
    return await db.insert('agros', animal.toMap());
  }

  Future<List<Agros>> getAllAnimals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('agros');
    return List.generate(maps.length, (i) {
      return Agros(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        precio: maps[i]['precio'],
        tipo: maps[i]['tipo'],
        imagenPath: maps[i]['imagenPath'],
      );
    });
  }

  Future<List<Agros>> getAllAgrosByType(String agroType) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'agros',
      where: 'tipo = ?',
      whereArgs: [agroType],
    );
    return List.generate(maps.length, (i) {
      return Agros(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        precio: maps[i]['precio'],
        tipo: maps[i]['tipo'],
        imagenPath: maps[i]['imagenPath'],
      );
    });
  }
}
