import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import '../../constants/text_styles.dart';

class WinScreen extends StatelessWidget {
  final VoidCallback onPlayAgain;
  final ConfettiController confettiController;

  const WinScreen({
    super.key,
    required this.onPlayAgain,
    required this.confettiController,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Win overlay
        Container(
          color: Colors.black.withValues(alpha: 0.8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bạn Thắng!', style: GameTextStyles.winner),
                const SizedBox(height: 20),
                const Text(
                  'BẠN ĐÃ SỐNG SÓT QUA ĐÈN ĐỎ ĐÈN XANH!',
                  style: GameTextStyles.subtitle,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: onPlayAgain,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Chơi lại',
                        style: GameTextStyles.button,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 15,
                        ),
                      ),
                      child: const Text(
                        'Trở lại MENU',
                        style: GameTextStyles.button,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: confettiController,
            blastDirection: pi / 2,
            maxBlastForce: 5,
            minBlastForce: 2,
            emissionFrequency: 0.05,
            numberOfParticles: 50,
            gravity: 0.05,
          ),
        ),
      ],
    );
  }
}
