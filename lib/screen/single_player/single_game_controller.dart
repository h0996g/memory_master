import 'package:memory_master/components/app_colors.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class SingleGameController extends GetxController {
  final int numPairs = 8;
  final RxList<int> numbers = <int>[].obs;
  final RxList<bool> flipped = <bool>[].obs;
  final RxInt previousIndex = RxInt(-1);
  final RxBool waiting = false.obs;
  final RxInt score = 0.obs;
  final RxInt steps = 0.obs;
  final int totalPairs = 8;
  final RxInt timeLeft = 60.obs;
  Timer? timer;
  final RxBool isGameActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeGame();
  }

  void initializeGame() {
    numbers.value =
        List.generate(numPairs, (index) => index + 1)
          ..addAll(List.generate(numPairs, (index) => index + 1))
          ..shuffle(Random());
    flipped.value = List.generate(numbers.length, (_) => false);
    previousIndex.value = -1;
    score.value = 0;
    steps.value = 0;
    timeLeft.value = 60;
    isGameActive.value = true;
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        isGameActive.value = false;
        showGameOverDialog();
      }
    });
  }

  void showGameOverDialog() {
    final isDark = Get.isDarkMode;
    final Color scoreColor = AppColors.singlePlayer;
    final Color stepColor = AppColors.localMultiplayer;

    Get.dialog(
      Dialog(
        backgroundColor: isDark ? AppColors.darkGrey2 : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.celebration, size: 48, color: Colors.amber),
              const SizedBox(height: 16),
              Text(
                "⏰ Time's Up!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : AppColors.primary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Score: ${score.value} / $totalPairs',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: scoreColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Steps: ${steps.value}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: stepColor,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        initializeGame();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Restart'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back(); // Close dialog
                        Get.back(); // Go home
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[400],
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Home'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void onCardTap(int index) {
    if (waiting.value || flipped[index] || !isGameActive.value) return;

    flipped[index] = true;

    if (previousIndex.value == -1) {
      previousIndex.value = index;
      steps.value++;
    } else {
      waiting.value = true;
      Future.delayed(const Duration(milliseconds: 500), () {
        if (numbers[previousIndex.value] == numbers[index]) {
          score.value++;
          if (score.value == totalPairs) {
            timer?.cancel();
            showWinDialog();
          }
        } else {
          flipped[previousIndex.value] = false;
          flipped[index] = false;
        }
        previousIndex.value = -1;
        waiting.value = false;
      });
    }
  }

  void showWinDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Congratulations!',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'You won!\nScore: ${score.value}/$totalPairs\nSteps: ${steps.value}\nTime left: ${timeLeft.value} seconds',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              initializeGame();
            },
            child: const Text(
              'Play Again',
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('Home', style: TextStyle(color: Colors.blueGrey)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
