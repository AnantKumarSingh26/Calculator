import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/logs/log_model.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('secure_calc.db');
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
      CREATE TABLE logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        eventType TEXT NOT NULL,
        description TEXT NOT NULL,
        timestamp TEXT NOT NULL,
        source TEXT NOT NULL
      )
    ''');
  }

  Future<void> insertLog(LogEvent log) async {
    final db = await database;
    await db.insert(
      'logs',
      log.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print('Logged to DB: ${log.description}'); // For debugging
  }

  Future<List<LogEvent>> getAllLogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('logs', orderBy: 'id DESC');
    return maps.map((map) => LogEvent.fromMap(map)).toList();
  }
}

// Expose the DatabaseService globally via Riverpod
final databaseProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});