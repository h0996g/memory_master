import 'package:memory_master/components/app_colors.dart';
import 'package:memory_master/components/widget/appbar.dart';
import 'package:memory_master/screen/local_multiplayer/local_multiplayer_game.dart';
import 'package:memory_master/screen/single_player/local_single_game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Card Recall',
        context: context,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              buildBeautifulTitle(context),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.95,
                  children: [
                    buildModeCard(
                      context,
                      title: 'Focus Mode',
                      // icon: Icons.person,
                      color: AppColors.singlePlayer,
                      onTap: () => Get.to(() => const SingleGameScreen()),
                    ),
                    buildModeCard(
                      context,
                      title: 'Duel Mode',
                      // icon: Icons.people,
                      color: AppColors.localMultiplayer,
                      onTap:
                          () =>
                              Get.to(() => const LocalMultiplayerGameScreen()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
