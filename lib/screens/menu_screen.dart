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
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/sprites/background_sprite.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Nội dung Menu (ở giữa màn hình)
          Center(
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
                      Shadow(offset: Offset(3, 3), blurRadius: 6, color: Colors.black54),
                      Shadow(offset: Offset(-1, -1), blurRadius: 2, color: Colors.red),
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
                      Shadow(offset: Offset(2, 2), blurRadius: 4, color: Colors.black54),
                    ],
                  ),
                ),
                const SizedBox(height: 60),

                // Red-Green Light
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
                      MaterialPageRoute(builder: (_) => RGLightGame(playerName: name)),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Jump Rope
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
                      MaterialPageRoute(builder: (_) => JRGameScreen(playerName: name)),
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Scores
                _buildGameButton(
                  context,
                  title: 'BẢNG ĐIỂM',
                  subtitle: 'Xem lịch sử điểm các lần chơi',
                  color: Colors.blueGrey,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScoresScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Nút nguồn (có thể chỉnh vị trí top/right/bottom/left tùy ý)
          Positioned(
            top: 70,   // chỉnh khoảng cách từ trên
            right: 20, // chỉnh khoảng cách từ phải
            child: IconButton(
              tooltip: 'Thoát game',
              icon: const Icon(Icons.power_settings_new,
                  color: Colors.white, size: 36),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Xác nhận thoát"),
                    content:
                        const Text("Bạn có chắc chắn muốn thoát game không?"),
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
                  SystemNavigator.pop();
                }
              },
            ),
          ),
        ],
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
