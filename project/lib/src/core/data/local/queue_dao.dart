import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../models/queue_operation.dart';
import 'database_helper.dart';

class QueueDao {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _uuid = const Uuid();

  Future<void> enqueue(String entity, String entityId, String op, Map<String, dynamic> payload) async {
    final db = await _dbHelper.database;
    final operation = QueueOperation(
      id: _uuid.v4(),
      entity: entity,
      entityId: entityId,
      op: op,
      payload: jsonEncode(payload),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );
    await db.insert('queue_operations', operation.toMap());
  }

  Future<List<QueueOperation>> getAllPending() async {
    final db = await _dbHelper.database;
    final maps = await db.query(
      'queue_operations',
      orderBy: 'created_at ASC',
    );
    return maps.map((map) => QueueOperation.fromMap(map)).toList();
  }

  Future<void> remove(String id) async {
    final db = await _dbHelper.database;
    await db.delete(
      'queue_operations',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateAttempt(String id, int attemptCount, String? error) async {
    final db = await _dbHelper.database;
    await db.update(
      'queue_operations',
      {
        'attempt_count': attemptCount,
        'last_error': error,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}