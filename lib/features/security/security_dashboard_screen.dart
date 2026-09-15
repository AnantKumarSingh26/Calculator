import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../logs/logs_provider.dart';

class SecurityDashboardScreen extends ConsumerWidget {
  const SecurityDashboardScreen({super.key});

  // Helper to format time without needing extra packages
  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsyncValue = ref.watch(logsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF101014),
      appBar: AppBar(
        backgroundColor: const Color(0xFF15151A),
        title: const Text(
          'SECURITY CENTER',
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.tealAccent,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.tealAccent),
      ),
      body: Column(
        children: [
          // Dashboard Header Area
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFF15151A),
              border: Border(bottom: BorderSide(color: Colors.teal, width: 2)),
            ),
            child: const Column(
              children: [
                Icon(Icons.security, size: 48, color: Colors.tealAccent),
                SizedBox(height: 12),
                Text(
                  'SYSTEM SECURE',
                  style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 3),
                ),
                SizedBox(height: 4),
                Text(
                  'Activity Logging: ENABLED',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                ),
              ],
            ),
          ),
          
          // Logs List Area
          Expanded(
            child: logsAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
              error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
              data: (logs) {
                if (logs.isEmpty) {
                  return const Center(
                    child: Text("No events recorded yet.", style: TextStyle(color: Colors.white54)),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return Card(
                      color: const Color(0xFF1E1E24),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      child: ListTile(
                        leading: const Icon(Icons.touch_app, color: Colors.tealAccent, size: 20),
                        title: Text(
                          'Key Pressed: ${log.description}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Source: ${log.source}',
                          style: const TextStyle(color: Colors.white54, fontSize: 12),
                        ),
                        trailing: Text(
                          _formatTime(log.timestamp),
                          style: const TextStyle(color: Colors.teal, fontFamily: 'monospace'),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}