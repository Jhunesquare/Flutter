import 'dart:convert';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/local/queue_dao.dart';
import '../data/local/task_dao.dart';
import '../data/remote/api_service.dart';

class SyncService {
  final QueueDao queueDao;
  final TaskDao taskDao;
  final ApiService api;
  final Connectivity connectivity = Connectivity();

  SyncService({
    required this.queueDao,
    required this.taskDao,
    required this.api,
  });

  Future<bool> hasConnectivity() async {
    final result = await connectivity.checkConnectivity();
    return result.any((r) => r != ConnectivityResult.none);
  }

  Future<void> syncPendingOperations() async {
    if (!await hasConnectivity()) return;

    final operations = await queueDao.getAllPending();
    
    for (final operation in operations) {
      try {
        await _processOperation(operation.id, operation.op, operation.entityId, operation.payload);
        await queueDao.remove(operation.id);
        await taskDao.updateSyncedAt(operation.entityId, DateTime.now().toUtc());
      } catch (e) {
        final newAttemptCount = operation.attemptCount + 1;
        await queueDao.updateAttempt(operation.id, newAttemptCount, e.toString());
        
        // Backoff exponencial: esperar 2^attemptCount segundos
        final delay = pow(2, min(newAttemptCount, 5)).toInt();
        await Future.delayed(Duration(seconds: delay));
      }
    }
  }

  Future<void> _processOperation(String opId, String op, String entityId, String payload) async {
    final data = jsonDecode(payload) as Map<String, dynamic>;

    switch (op) {
      case 'CREATE':
        await api.createTask(data, idempotencyKey: opId);
        break;
      case 'UPDATE':
        await api.updateTask(entityId, data);
        break;
      case 'DELETE':
        await api.deleteTask(entityId);
        break;
    }
  }
}
