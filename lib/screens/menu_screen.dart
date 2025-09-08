// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../game/JRGame/jr_game_screen.dart';
import 'scores_screen.dart';
import '../widgets/player_name_dialog.dart';
import '../game/RGLight/rg_light_game.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/sprites/background_sprite.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Trò Chơi Coan Mực',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFD62598),
                  fontFamily: 'Courier',
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3),
                      blurRadius: 6,
                      color: Colors.black54,
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
                'MENU \nChọn thử thách của bạn',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Courier',
                  letterSpacing: 1.0,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black54,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),

              // Button Red-Green Light (RGLight) with player name dialog
              _buildGameButton(
                context,
                title: 'Red-Green Light',
                subtitle: 'Chạy khi đèn xanh, đứng khi đèn đỏ',
                color: Colors.redAccent,
                onTap: () async {
                  final name = await askPlayerName(context);
                  if (name == null || name.isEmpty) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RGLightGame(playerName: name),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // Button Jump Rope (JRGame) with player name dialog
              _buildGameButton(
                context,
                title: 'Jump Rope',
                subtitle: 'Nhảy dây đúng nhịp',
                color: Colors.teal,
                onTap: () async {
                  final name = await askPlayerName(context);
                  if (name == null || name.isEmpty) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => JRGameScreen(playerName: name),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              // Button Scores Screen
              _buildGameButton(
                context,
                title: 'BẢNG ĐIỂM',
                subtitle: 'Xem lịch sử điểm các lần chơi',
                color: Colors.blueGrey,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ScoresScreen(),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),

              // Exit Game (nhỏ hơn)
              GestureDetector(
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder:
                        (ctx) => AlertDialog(
                          title: const Text("Xác nhận thoát"),
                          content: const Text(
                            "Bạn có chắc chắn muốn thoát game không?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text("Không"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: const Text("Có"),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true) {
                    SystemNavigator.pop(); // thoát app
                  }
                },
                child: Container(
                  width:
                      MediaQuery.of(context).size.width * 0.5, // nhỏ hơn ~50%
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Text(
                    "THOÁT GAME",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Courier',
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.9), color.withOpacity(0.7)],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                fontFamily: 'Courier',
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontFamily: 'Courier',
                fontWeight: FontWeight.w600,
                letterSpacing: 1.0,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
