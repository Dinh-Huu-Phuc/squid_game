// ignore_for_file: prefer_interpolation_to_compose_strings

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

  // Không async, không await – chỉ tạo Future mới và gán lại trong setState
  void _reload() {
    if (!mounted) return;
    setState(() {
      _future = ScoreService.getScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bảng điểm'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Xóa tất cả',
            onPressed: () async {
              await ScoreService.clearAll();
              _reload();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ScoreEntry>>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Lỗi: ${snap.error}'));
          }
          final scores = snap.data ?? const <ScoreEntry>[];
          if (scores.isEmpty) {
            return const Center(child: Text('Chưa có điểm nào, chơi thử đi!'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: scores.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (c, i) {
              final s = scores[i];
              return ListTile(
                leading: CircleAvatar(child: Text('${s.score}')),
                title: Text('${s.playerName} — ${s.mode} — ${s.won ? 'Thắng' : 'Thua'}'),
                subtitle: Text(
                  (s.won ? 'Còn ${s.timeLeft}s/${s.duration}s' : '0/${s.duration}s') +
                  ' • ${s.createdAt.toLocal()}',
                ),
                trailing: Text(
                  '${s.score}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
