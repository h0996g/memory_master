import 'dart:math';
import 'package:memory_master/components/app_colors.dart';
import 'package:memory_master/components/widget/appbar.dart';
import 'package:memory_master/screen/local_multiplayer/local_multiplayer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_master/components/components.dart';

class LocalMultiplayerGameScreen extends StatelessWidget {
  const LocalMultiplayerGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalMultiplayerController gameController = Get.put(
      LocalMultiplayerController(),
    );

    gameController.setShowGameOverDialogCallback(
      () => _showGameOverDialog(context, gameController),
    );

    return Scaffold(
      appBar: buildAppBar(title: 'Duel Mode', context: context),
      body: SafeArea(
        child: Column(
          children: [
            // PLAYER 1 HEADER ZONE
            _buildPlayerBanner(
              name: 'Player 1',
              score: gameController.scorePlayer1,
              timeLeft: gameController.timeLeftPlayer1,
              isActive: gameController.currentPlayer,
              isPlayer1: true,
              color: AppColors.singlePlayer,
            ),

            const SizedBox(height: 8),

            // SHARED TIMER (in center)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetX<LocalMultiplayerController>(
                builder:
                    (_) => buildProgressBar(
                      gameController.timeLeftPlayer1.value,
                      gameController.timeLeftPlayer2.value,
                      context,
                    ),
              ),
            ),

            const SizedBox(height: 8),

            // GAME GRID
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildGameGrid(gameController),
              ),
            ),

            const SizedBox(height: 8),

            // PLAYER 2 FOOTER ZONE
            _buildPlayerBanner(
              name: 'Player 2',
              score: gameController.scorePlayer2,
              timeLeft: gameController.timeLeftPlayer2,
              isActive: gameController.currentPlayer,
              isPlayer1: false,
              color: AppColors.localMultiplayer,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerBanner({
    required String name,
    required RxInt score,
    required RxInt timeLeft,
    required RxInt isActive,
    required bool isPlayer1,
    required Color color,
  }) {
    final isDark = Get.isDarkMode;
    return Obx(() {
      final active = isActive.value == (isPlayer1 ? 1 : 2);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color:
              active
                  ? color.withOpacity(0.15)
                  : (isDark ? AppColors.darkGrey2 : Colors.grey[200]),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(isPlayer1 ? 0 : 20),
            bottom: Radius.circular(isPlayer1 ? 20 : 0),
          ),
          border: Border(
            top:
                isPlayer1
                    ? BorderSide.none
                    : BorderSide(color: color.withOpacity(0.3), width: 2),
            bottom:
                isPlayer1
                    ? BorderSide(color: color.withOpacity(0.3), width: 2)
                    : BorderSide.none,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.person, color: color),
            const SizedBox(width: 8),
            Text(
              name,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              'Score: ${score.value}',
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '⏱ ${timeLeft.value}s',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? Colors.white60 : Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    });
  }

  void _showGameOverDialog(
    BuildContext context,
    LocalMultiplayerController gameController,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          backgroundColor: isDark ? AppColors.darkGrey2 : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            '🏁 Game Over',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : AppColors.primary,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildResultRow(
                'Player 1',
                gameController.scorePlayer1.value,
                AppColors.singlePlayer,
              ),
              _buildResultRow(
                'Player 2',
                gameController.scorePlayer2.value,
                AppColors.localMultiplayer,
              ),
              const SizedBox(height: 12),
              Text(
                '🧠 Steps: ${gameController.steps.value}',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.grey[800],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                gameController.initializeGame();
              },
              child: const Text('Restart'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Home'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildResultRow(String label, int score, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, color: color),
          ),
          const Spacer(),
          Text(
            '$score pts',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameGrid(LocalMultiplayerController gameController) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double gridWidth = constraints.maxWidth;
        double gridHeight = constraints.maxHeight;
        double itemSize = gridWidth / 4;
        int rowCount = (gridHeight / itemSize).floor();
        rowCount = min(rowCount, (gameController.numbers.length / 4).ceil());

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: rowCount * 4,
          itemBuilder: (context, index) {
            if (index >= gameController.numbers.length) {
              return const SizedBox();
            }
            return GetX<LocalMultiplayerController>(
              builder:
                  (_) => GestureDetector(
                    onTap: () => gameController.onCardTap(index),
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                        begin: 0,
                        end: gameController.flipped[index] ? pi : 0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      builder: (
                        BuildContext context,
                        double value,
                        Widget? child,
                      ) {
                        return Transform(
                          transform:
                              Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..rotateY(value),
                          alignment: Alignment.center,
                          child:
                              value < pi / 2
                                  ? buildCardFront(context)
                                  : Transform(
                                    transform: Matrix4.identity()..rotateY(pi),
                                    alignment: Alignment.center,
                                    child: buildCardBack(
                                      index,
                                      gameController.numbers,
                                      context,
                                    ),
                                  ),
                        );
                      },
                    ),
                  ),
            );
          },
        );
      },
    );
  }
}
