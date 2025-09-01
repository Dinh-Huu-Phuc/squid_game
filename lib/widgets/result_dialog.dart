import 'package:flutter/material.dart';

Future<void> showGameResultDialog(
  BuildContext context, {
  required bool won,
  required int score, // 0..100
  int? timeLeft,      
  int? duration,      
}) async {
  final title = won ? ' Thắng rồi!' : ' Thua mất rồi!';
  final desc = won
      ? 'Bạn đã hoàn thành với $score/100 điểm.'
      : 'Bạn nhận $score/100 điểm. Cố lên lần sau nhé!';
  final timeText = (timeLeft != null && duration != null)
      ? '\nThời gian: ${timeLeft}s / ${duration}s'
      : '';

  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text('$desc$timeText'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Đóng'),
        ),
      ],
    ),
  );
}
