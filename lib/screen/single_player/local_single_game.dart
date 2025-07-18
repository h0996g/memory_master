import 'package:memory_master/components/widget/appbar.dart';
import 'package:memory_master/components/components.dart';
import 'package:memory_master/screen/single_player/single_game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class SingleGameScreen extends StatelessWidget {
  const SingleGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SingleGameController());

    return Scaffold(
      appBar: buildAppBar(title: 'Focus Mode', context: context),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),

            // TOP HUD BAR: Timer + Score + Steps
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GetX<SingleGameController>(
                builder:
                    (_) => buildHudBar(
                      context,
                      timeLeft: controller.timeLeft.value,
                      score: controller.score.value,
                      totalPairs: controller.totalPairs,
                      steps: controller.steps.value,
                    ),
              ),
            ),

            const SizedBox(height: 24),

            // GAME ARENA
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.05),
                ),
                child: _buildGameGrid(controller),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameGrid(SingleGameController controller) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
      ),
      itemCount: controller.numbers.length,
      itemBuilder: (context, index) {
        return GetX<SingleGameController>(
          builder: (_) {
            return GestureDetector(
              onTap: () => controller.onCardTap(index),
              child: TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: controller.flipped[index] ? pi : 0,
                ),
                duration: const Duration(milliseconds: 300),
                builder: (context, value, child) {
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
                                controller.numbers,
                                context,
                              ),
                            ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
