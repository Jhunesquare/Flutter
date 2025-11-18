import 'package:sqflite/sqflite.dart';
import '../../models/task.dart';
import 'database_helper.dart';

class TaskDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Task>> getAll() async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'deleted = ?',
      whereArgs: [0],
      orderBy: 'updated_at DESC',
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<List<Task>> getPending() async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'deleted = ? AND completed = ?',
      whereArgs: [0, 0],
      orderBy: 'updated_at DESC',
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<List<Task>> getCompleted() async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'deleted = ? AND completed = ?',
      whereArgs: [0, 1],
      orderBy: 'updated_at DESC',
    );
    return maps.map((map) => Task.fromMap(map)).toList();
  }

  Future<Task?> getById(String id) async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'tasks',
      where: 'id = ? AND deleted = ?',
      whereArgs: [id, 0],
    );
    if (maps.isEmpty) return null;
    return Task.fromMap(maps.first);
  }

  Future<void> insertOrUpdate(Task task) async {
    final db = await _dbHelper.database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> softDelete(String id, DateTime deletedAt) async {
    final db = await _dbHelper.database;
    await db.update(
      'tasks',
      {'deleted': 1, 'updated_at': deletedAt.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateSyncedAt(String id, DateTime syncedAt) async {
    final db = await _dbHelper.database;
    await db.update(
      'tasks',
      {'synced_at': syncedAt.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteAll() async {
    final db = await _dbHelper.database;
    await db.delete('tasks');
  }
}