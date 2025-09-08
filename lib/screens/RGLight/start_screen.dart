import 'package:flutter/material.dart';
import '../../constants/text_styles.dart';

class StartScreen extends StatelessWidget {
  final VoidCallback onStartGame;

  const StartScreen({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Đèn Đỏ - Đèn Xanh', ),
        backgroundColor: Colors.transparent, // trong suốt
        elevation: 0, // bỏ bóng
      ),
      extendBodyBehindAppBar: true, // để nền phủ cả AppBar
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/sprites/background_sprite.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
                child: const Text('Bắt đầu game', style: GameTextStyles.button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
