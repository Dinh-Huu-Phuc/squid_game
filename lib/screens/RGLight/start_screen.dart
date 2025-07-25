import 'package:flutter/material.dart';
import '../../constants/text_styles.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStartGame;

  const StartScreen({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'ĐÈN ĐỎ\nĐÈN XANH',
            textAlign: TextAlign.center,
            style: GameTextStyles.mainTitle,
          ),
          const SizedBox(height: 20),
          const Text(
            'CHẠM ĐỂ DI CHUYỂN KHI ĐÓNG\nKHÔNG DI CHUYỂN KHI ĐỎ\nĐẾN VỊ TRÍ TRONG VÒNG 30 GIÂY!',
            textAlign: TextAlign.center,
            style: GameTextStyles.instructions,
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: onStartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            child: const Text('Bắt đầu game', style: GameTextStyles.button),
          ),
        ],
      ),
    );
  }
}
