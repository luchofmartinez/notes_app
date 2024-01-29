import 'package:notes_app/models/note.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRepository {
  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();
  static const _tableName = "Notas";
  static const _versionDB = 2;

  Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes_app_db.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: _versionDB, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      create table $_tableName ( 
        id integer primary key autoincrement, 
        descripcion text not null)
      ''');
  }

  Future<void> insert({required Note note}) async {
    try {
      final db = await instance.database;
      await db.insert(_tableName, note.toMap());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Note>> getAllTodos() async {
    final db = await instance.database;

    final result = await db.query(_tableName);

    return result.map((json) => Note.fromJson(json)).toList();
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(Note note) async {
    try {
      final db = await instance.database;
      db.update(
        _tableName,
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
