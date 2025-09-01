import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ScoreEntry {
  final String playerName;
  final String mode; // "RGLight" | "JRope"
  final bool won; // thắng?
  final int timeLeft; // giây còn lại khi thắng (thua = 0)
  final int duration; // tổng thời gian game
  final int score; // 0..100
  final DateTime createdAt; // thời điểm lưu

  ScoreEntry({
    required this.playerName,
    required this.mode,
    required this.won,
    required this.timeLeft,
    required this.duration,
    required this.score,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'playerName': playerName,
    'mode': mode,
    'won': won,
    'timeLeft': timeLeft,
    'duration': duration,
    'score': score,
    'createdAt': createdAt.toIso8601String(),
  };

  factory ScoreEntry.fromJson(Map<String, dynamic> json) => ScoreEntry(
    playerName: (json['playerName'] as String?) ?? 'Player',
    mode: json['mode'] as String,
    won: json['won'] as bool,
    timeLeft: json['timeLeft'] as int,
    duration: json['duration'] as int,
    score: json['score'] as int,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}

class ScoreService {
  static const _key = 'vm_squid_scores';

  static int computeScore({
    required bool won,
    required int timeLeft,
    required int duration,
  }) {
    if (!won) return 0;
    if (duration <= 0) return 0;
    final s = ((timeLeft / duration) * 100).round();
    return s.clamp(0, 100);
  }

  static Future<void> addScore(ScoreEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? <String>[];
    list.insert(0, jsonEncode(entry.toJson())); // mới nhất lên đầu
    await prefs.setStringList(_key, list);
  }

  static Future<List<ScoreEntry>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? <String>[];
    return list
        .map((e) => ScoreEntry.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
    // có thể phân trang/giới hạn sau này
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
