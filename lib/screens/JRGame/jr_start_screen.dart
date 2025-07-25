import 'package:flutter/material.dart';
import '../../game/JRGame/constants/jr_game_constants.dart';

class JRStartScreen extends StatelessWidget {
  final VoidCallback onStartGame;

  const JRStartScreen({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Trò chơi\ncon mực',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: JRGameConstants.primaryRed,
              fontFamily: 'Courier',
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  offset: Offset(3, 3),
                  blurRadius: 6,
                  color: Colors.black,
                ),
                Shadow(
                  offset: Offset(-1, -1),
                  blurRadius: 2,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Thử thách\nNhảy dây',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: JRGameConstants.textWhite,
              fontFamily: 'Courier',
              letterSpacing: 2.0,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const Text(
            'Quy tắc:\n• Di chuyển LÊN đường ray để thoát\n• Nhảy qua dây để sống sót\n• Tránh chạm vào dây\n• 30 giây để lên đến đỉnh',
            style: TextStyle(
              fontSize: 16,
              color: JRGameConstants.textWhite,
              fontFamily: 'Courier',
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
              height: 1.5,
              shadows: [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: onStartGame,
            style: ElevatedButton.styleFrom(
              backgroundColor: JRGameConstants.primaryRed,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            ),
            child: const Text(
              'Bắt đầu GAME',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontFamily: 'Courier',
                letterSpacing: 2.0,
                color: JRGameConstants.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
