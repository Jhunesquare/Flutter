import 'package:meta/meta.dart';

class Task {
  final String id;
  final String title;
  final bool completed;
  final DateTime updatedAt;
  final bool deleted;
  final DateTime? syncedAt;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.updatedAt,
    this.deleted = false,
    this.syncedAt,
  });

  Task copyWith(
      {String? id,
      String? title,
      bool? completed,
      DateTime? updatedAt,
      bool? deleted,
      DateTime? syncedAt}) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      completed: completed ?? this.completed,
      updatedAt: updatedAt ?? this.updatedAt,
      deleted: deleted ?? this.deleted,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed ? 1 : 0,
      'updated_at': updatedAt.toIso8601String(),
      'deleted': deleted ? 1 : 0,
      'synced_at': syncedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toJsonApi() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      completed: map['completed'] == 1,
      updatedAt: DateTime.parse(map['updated_at']),
      deleted: map['deleted'] == 1,
      syncedAt:
          map['synced_at'] != null ? DateTime.parse(map['synced_at']) : null,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
