import '../../models/task.dart';
import '../local/task_dao.dart';
import '../local/queue_dao.dart';
import '../remote/api_service.dart';
import 'package:uuid/uuid.dart';

class TaskRepository {
  final TaskDao taskDao;
  final QueueDao queueDao;
  final ApiService api;
  final _uuid = const Uuid();

  TaskRepository({
    required this.taskDao,
    required this.queueDao,
    required this.api,
  });

  Future<List<Task>> getAll() async {
    return taskDao.getAll();
  }

  Future<List<Task>> getPending() async {
    return taskDao.getPending();
  }

  Future<List<Task>> getCompleted() async {
    return taskDao.getCompleted();
  }

  Future<void> createTask(String title) async {
    final id = _uuid.v4();
    final now = DateTime.now().toUtc();
    final task = Task(id: id, title: title, completed: false, updatedAt: now);
    await taskDao.insertOrUpdate(task);
    await queueDao.enqueue('tasks', id, 'CREATE', task.toJsonApi());
  }

  Future<void> updateTask(Task t) async {
    final newT = t.copyWith(updatedAt: DateTime.now().toUtc());
    await taskDao.insertOrUpdate(newT);
    await queueDao.enqueue('tasks', newT.id, 'UPDATE', newT.toJsonApi());
  }

  Future<void> deleteTask(Task t) async {
    final now = DateTime.now().toUtc();
    await taskDao.softDelete(t.id, now);
    await queueDao.enqueue('tasks', t.id, 'DELETE', {'id': t.id});
  }

  Future<void> refreshFromServer() async {
    try {
      final remoteTasks = await api.getTasks();
      for (final task in remoteTasks) {
        final local = await taskDao.getById(task.id);
        if (local == null || task.updatedAt.isAfter(local.updatedAt)) {
          await taskDao.insertOrUpdate(task);
        }
      }
    } catch (e) {
      // Silently fail, local data is still valid
    }
  }
}