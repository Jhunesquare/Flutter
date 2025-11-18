import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/data/local/task_dao.dart';
import 'src/core/data/local/queue_dao.dart';
import 'src/core/data/remote/api_service.dart';
import 'src/core/data/repositories/task_repository.dart';
import 'src/core/services/sync_service.dart';
import 'src/providers/task_provider.dart';
import 'src/screens/task_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Configurar servicios
    final taskDao = TaskDao();
    final queueDao = QueueDao();
    final apiService = ApiService(
      baseUrl: 'http://localhost:3000', // Cambiar por tu API
    );

    final repository = TaskRepository(
      taskDao: taskDao,
      queueDao: queueDao,
      api: apiService,
    );

    final syncService = SyncService(
      queueDao: queueDao,
      taskDao: taskDao,
      api: apiService,
    );

    return ChangeNotifierProvider(
      create: (_) => TaskProvider(
        repository: repository,
        syncService: syncService,
      ),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        home: const TaskListScreen(),
      ),
    );
  }
}
