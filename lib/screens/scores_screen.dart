import 'package:flutter/material.dart';
import '../services/score_services.dart';

class ScoresScreen extends StatefulWidget {
  const ScoresScreen({super.key});

  @override
  State<ScoresScreen> createState() => _ScoresScreenState();
}

class _ScoresScreenState extends State<ScoresScreen> {
  late Future<List<ScoreEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = ScoreService.getScores();
  }

  Future<void> _reload() async {
    final data = await ScoreService.getScores();
    if (mounted) setState(() => _future = Future.value(data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điểm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await ScoreService.clearAll();
              await _reload();
            },
            tooltip: 'Xóa tất cả',
          ),
        ],
      ),
      body: FutureBuilder<List<ScoreEntry>>(
        future: _future,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final scores = snap.data!;
          if (scores.isEmpty) {
            return const Center(child: Text('Chưa có điểm nào, chơi thử đi!'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemBuilder: (c, i) {
              final s = scores[i];
              return ListTile(
                leading: CircleAvatar(child: Text('${s.score}')),
                title: Text('${s.playerName} — ${s.mode} — ${s.won ? 'Thắng' : 'Thua'}'),
                subtitle: Text(
                  (s.won ? 'Còn ${s.timeLeft}s/${s.duration}s' : '0/${s.duration}s')
                  + ' • ${s.createdAt.toLocal()}',
                ),
                trailing: Text('${s.score}', style: const TextStyle(fontWeight: FontWeight.bold)),
              );
            },
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemCount: scores.length,
          );
        },
      ),
    );
  }
}
