class QueueOperation {
  final String id;
  final String entity;
  final String entityId;
  final String op; // CREATE | UPDATE | DELETE
  final String payload;
  final int createdAt;
  final int attemptCount;
  final String? lastError;

  QueueOperation({
    required this.id,
    required this.entity,
    required this.entityId,
    required this.op,
    required this.payload,
    required this.createdAt,
    this.attemptCount = 0,
    this.lastError,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entity': entity,
      'entity_id': entityId,
      'op': op,
      'payload': payload,
      'created_at': createdAt,
      'attempt_count': attemptCount,
      'last_error': lastError,
    };
  }

  factory QueueOperation.fromMap(Map<String, dynamic> map) {
    return QueueOperation(
      id: map['id'],
      entity: map['entity'],
      entityId: map['entity_id'],
      op: map['op'],
      payload: map['payload'],
      createdAt: map['created_at'],
      attemptCount: map['attempt_count'],
      lastError: map['last_error'],
    );
  }

  QueueOperation copyWith({
    int? attemptCount,
    String? lastError,
  }) {
    return QueueOperation(
      id: id,
      entity: entity,
      entityId: entityId,
      op: op,
      payload: payload,
      createdAt: createdAt,
      attemptCount: attemptCount ?? this.attemptCount,
      lastError: lastError ?? this.lastError,
    );
  }
}
