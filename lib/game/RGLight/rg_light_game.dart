import 'package:flutter/material.dart';
import '../RGLight/game_controller.dart';
import '../../widgets/player_widget.dart';
import '../../widgets/doll_widget.dart';
import '../../widgets/finish_line_widget.dart';
import '../../widgets/game_ui.dart';
import '../../widgets/move_button.dart';
import '../../screens/RGLight/start_screen.dart';
import '../../screens/RGLight/game_over_screen.dart';
import '../../screens/RGLight/win_screen.dart';
import '../../widgets/result_dialog.dart';
import '../../constants/game_constants.dart';

class RGLightGame extends StatefulWidget {
  final String playerName;
  const RGLightGame({super.key, required this.playerName});

  @override
  State<RGLightGame> createState() => _RGLightGameState();
}

class _RGLightGameState extends State<RGLightGame>
    with TickerProviderStateMixin {
  late final GameController _gameController;

  @override
  void initState() {
    super.initState();
    _gameController = GameController(
      playerName: widget.playerName, // Truyền tên người chơi
      onResult: ({
        required bool won,
        required int score,
        required int timeLeft,
        required int duration,
        required String playerName,
      }) async {
        if (!mounted) return;
        // Hiện thông báo kết quả bằng SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              won
                  ? '$playerName Thắng - $score/100 điểm'
                  : '$playerName Thua - 0/100 điểm',
            ),
          ),
        );
        // Nếu muốn hiện dialog kết quả, có thể gọi hàm bên dưới (comment nếu không dùng)
        /*
        await showGameResultDialog(context,
          won: won,
          score: score,
          timeLeft: timeLeft,
          duration: duration,
          playerName: playerName,
        );
        */
      },
    );
    _gameController.initialize(this);
  }

  @override
  void dispose() {
    _gameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _gameController,
        builder: (context, child) {
          return Stack(
            children: [
              // Background
              _buildBackground(),

              // Game elements (chỉ hiện khi game bắt đầu)
              if (_gameController.gameState.isGameStarted) ...[
                GameUI(gameState: _gameController.gameState),

                DollWidget(
                  gameState: _gameController.gameState,
                  dollRotationController: _gameController.dollRotationController,
                ),

                const FinishLineWidget(),

                PlayerWidget(gameState: _gameController.gameState),

                MoveButton(
                  gameState: _gameController.gameState,
                  onMove: _gameController.movePlayer,
                ),
              ],

              // Màn hình theo trạng thái game
              if (!_gameController.gameState.isGameStarted)
                StartScreen(onStartGame: _gameController.startGame),

              if (_gameController.gameState.isPlayerDead)
                GameOverScreen(onTryAgain: _gameController.resetGame),

              if (_gameController.gameState.hasWon)
                WinScreen(
                  onPlayAgain: _gameController.resetGame,
                  confettiController: _gameController.confettiController,
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/sprites/background_sprite.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
