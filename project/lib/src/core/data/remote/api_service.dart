import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../models/task.dart';

class ApiService {
  final String baseUrl;
  final Duration timeout;

  ApiService({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 10),
  });

  Future<List<Task>> getTasks() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/tasks')).timeout(timeout);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        throw ApiException('Error ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    } on http.ClientException {
      throw ApiException('Error de cliente HTTP');
    } catch (e) {
      throw ApiException('Error: $e');
    }
  }

  Future<Task> createTask(Map<String, dynamic> taskData,
      {String? idempotencyKey}) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      if (idempotencyKey != null) {
        headers['Idempotency-Key'] = idempotencyKey;
      }

      final response = await http
          .post(
            Uri.parse('$baseUrl/tasks'),
            headers: headers,
            body: jsonEncode(taskData),
          )
          .timeout(timeout);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Task.fromJson(jsonDecode(response.body));
      } else {
        throw ApiException('Error ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    } catch (e) {
      throw ApiException('Error: $e');
    }
  }

  Future<Task> updateTask(String id, Map<String, dynamic> taskData) async {
    try {
      final response = await http
          .put(
            Uri.parse('$baseUrl/tasks/$id'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(taskData),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return Task.fromJson(jsonDecode(response.body));
      } else {
        throw ApiException('Error ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    } catch (e) {
      throw ApiException('Error: $e');
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/tasks/$id')).timeout(timeout);

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw ApiException('Error ${response.statusCode}: ${response.body}');
      }
    } on SocketException {
      throw ApiException('Sin conexión a internet');
    } catch (e) {
      throw ApiException('Error: $e');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}
