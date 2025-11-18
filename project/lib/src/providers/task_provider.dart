import 'package:flutter/material.dart';
import '../core/models/task.dart';
import '../core/data/repositories/task_repository.dart';
import '../core/services/sync_service.dart';

enum TaskFilter { all, pending, completed }

class TaskProvider with ChangeNotifier {
  final TaskRepository repository;
  final SyncService syncService;

  List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;
  bool _isLoading = false;
  String? _errorMessage;

  List<Task> get tasks {
    switch (_filter) {
      case TaskFilter.pending:
        return _tasks.where((t) => !t.completed).toList();
      case TaskFilter.completed:
        return _tasks.where((t) => t.completed).toList();
      default:
        return _tasks;
    }
  }

  TaskFilter get filter => _filter;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  TaskProvider({required this.repository, required this.syncService}) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tasks = await repository.getAll();
      _isLoading = false;
      notifyListeners();

      // Refrescar en segundo plano
      _refreshInBackground();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _refreshInBackground() async {
    try {
      await repository.refreshFromServer();
      await syncService.syncPendingOperations();
      _tasks = await repository.getAll();
      notifyListeners();
    } catch (e) {
      // Silently fail
    }
  }

  void setFilter(TaskFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> createTask(String title) async {
    try {
      await repository.createTask(title);
      await loadTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleTask(Task task) async {
    try {
      final updated = task.copyWith(completed: !task.completed);
      await repository.updateTask(updated);
      await loadTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task, String newTitle) async {
    try {
      final updated = task.copyWith(title: newTitle);
      await repository.updateTask(updated);
      await loadTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await repository.deleteTask(task);
      await loadTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> syncNow() async {
    _isLoading = true;
    notifyListeners();

    try {
      await syncService.syncPendingOperations();
      await repository.refreshFromServer();
      await loadTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}
