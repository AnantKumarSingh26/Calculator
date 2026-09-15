import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/database_service.dart';
import 'log_model.dart';

// We use FutureProvider because fetching from SQLite is asynchronous.
// autoDispose ensures the database is queried fresh every time we open the screen.
final logsProvider = FutureProvider.autoDispose<List<LogEvent>>((ref) async {
  final db = ref.watch(databaseProvider);
  return await db.getAllLogs();
});