import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _db;
  static const String DB_NAME = 'tasks_app.db';

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), DB_NAME);
    return openDatabase(path, version: 1, onCreate: (db, v) async {
      await db.execute('''CREATE TABLE tasks (
id TEXT PRIMARY KEY,
title TEXT NOT NULL,
completed INTEGER NOT NULL DEFAULT 0,
updated_at TEXT NOT NULL,
deleted INTEGER NOT NULL DEFAULT 0
)''');

      await db.execute('''CREATE TABLE queue_operations (
id TEXT PRIMARY KEY,
entity TEXT,
entity_id TEXT,
op TEXT,
payload TEXT,
created_at INTEGER,
attempt_count INTEGER DEFAULT 0,
last_error TEXT
)''');
    });
  }
}
