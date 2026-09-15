class LogEvent {
  final int? id;
  final String eventType;
  final String description;
  final DateTime timestamp;
  final String source;

  LogEvent({
    this.id,
    required this.eventType,
    required this.description,
    required this.timestamp,
    required this.source,
  });

  // Convert a LogEvent into a Map to save to SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'eventType': eventType,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'source': source,
    };
  }

  // Convert a SQLite Map back into a LogEvent
  factory LogEvent.fromMap(Map<String, dynamic> map) {
    return LogEvent(
      id: map['id'],
      eventType: map['eventType'],
      description: map['description'],
      timestamp: DateTime.parse(map['timestamp']),
      source: map['source'],
    );
  }
}