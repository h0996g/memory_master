// ignore_for_file: unnecessary_const

import 'package:memory_master/components/app_colors.dart';
import 'package:memory_master/widget/compact_player_card_online.dart';
import 'package:flutter/material.dart';

Widget buildBackgroundShapes(BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Stack(
    children: [
      Positioned(
        top: -50,
        left: -50,
        child: _buildShape(
          200,
          isDarkMode
              ? Colors.grey[800]!.withOpacity(0.3)
              : const Color(0xFFFFCCBC).withOpacity(0.5),
          context,
        ),
      ),
      Positioned(
        bottom: -30,
        right: -30,
        child: _buildShape(
          150,
          isDarkMode
              ? Colors.grey[700]!.withOpacity(0.3)
              : const Color(0xFFB2DFDB).withOpacity(0.5),
          context,
        ),
      ),
      Positioned(
        top: 100,
        right: -20,
        child: _buildShape(
          100,
          isDarkMode
              ? Colors.grey[600]!.withOpacity(0.3)
              : const Color(0xFFFFECB3).withOpacity(0.5),
          context,
        ),
      ),
    ],
  );
}

Widget _buildShape(double size, Color color, BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(
          color:
              isDarkMode
                  ? Colors.black.withOpacity(0.2)
                  : color.withOpacity(0.3),
          blurRadius: 20,
          spreadRadius: 5,
        ),
      ],
    ),
  );
}

//! -----------------------Home Screen-----------------------
Widget buildBeautifulTitle(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors:
            isDark
                ? [Colors.grey[850]!, Colors.grey[700]!]
                : [AppColors.primary, AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color:
              isDark
                  ? Colors.black.withOpacity(0.4)
                  : AppColors.primary.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text(
          'Card',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Recall',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            color: Colors.white,
            letterSpacing: 6,
          ),
        ),
      ],
    ),
  );
}

Widget buildModeCard(
  BuildContext context, {
  required String title,
  required Color color,
  required VoidCallback onTap,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color:
            isDark ? Colors.white.withOpacity(0.04) : color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color:
                isDark ? Colors.black.withOpacity(0.3) : color.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
      child: Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : Colors.grey[900],
          ),
        ),
      ),
    ),
  );
}

//  -----------------------End of Home Screen-----------------------

//!------------------------Local Multiplayer Game------------------------
Widget buildProgressBar(
  int timeLeftPlayer1,
  int timeLeftPlayer2,
  BuildContext context,
) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final total = (timeLeftPlayer1 + timeLeftPlayer2).clamp(0, 60) / 60;

  return Container(
    height: 14,
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[800] : Colors.grey[300],
      borderRadius: BorderRadius.circular(30),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: LinearProgressIndicator(
        value: total,
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(
          isDark ? AppColors.primary.withOpacity(0.7) : AppColors.secondary,
        ),
      ),
    ),
  );
}

Widget buildPlayerCards(
  int scorePlayer1,
  int timeLeftPlayer1,
  int scorePlayer2,
  int timeLeftPlayer2,
  int currentPlayer,
  BuildContext context,
) {
  return Row(
    children: [
      Expanded(
        child: _buildPlayerCard(
          context: context,
          name: 'Player 1',
          score: scorePlayer1,
          timeLeft: timeLeftPlayer1,
          isActive: currentPlayer == 1,
          color: AppColors.singlePlayer,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildPlayerCard(
          context: context,
          name: 'Player 2',
          score: scorePlayer2,
          timeLeft: timeLeftPlayer2,
          isActive: currentPlayer == 2,
          color: AppColors.localMultiplayer,
        ),
      ),
    ],
  );
}

Widget _buildPlayerCard({
  required String name,
  required int score,
  required int timeLeft,
  required bool isActive,
  required Color color,
  required BuildContext context,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: isDark ? AppColors.darkGrey2 : Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(
        color: isActive ? color : Colors.transparent,
        width: isActive ? 2 : 0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Text(
            name.substring(name.length - 1),
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isDark ? Colors.white : Colors.grey[900],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Score: $score',
          style: TextStyle(
            fontSize: 14,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '⏱ $timeLeft sec',
          style: TextStyle(
            fontSize: 13,
            color: isDark ? Colors.white70 : Colors.grey[600],
          ),
        ),
      ],
    ),
  );
}

Widget buildCardFront(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors:
            isDark
                ? [AppColors.darkGrey3, AppColors.darkGrey2]
                : [Colors.grey[200]!, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color:
              isDark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.2),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: const Center(
      child: Text(
        '?',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget buildCardBack(int index, List<int> numbers, BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors:
            isDark
                ? [AppColors.primary.withOpacity(0.9), AppColors.secondary]
                : [AppColors.primary, AppColors.secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(
          color:
              isDark
                  ? Colors.orange.withOpacity(0.4)
                  : AppColors.primary.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Center(
      child: Text(
        '${numbers[index]}',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

// -----------------------End of Local Multiplayer Game-----------------------

//! -----------------------Single Player Game-----------------------
Widget buildHudBar(
  BuildContext context, {
  required int timeLeft,
  required int score,
  required int totalPairs,
  required int steps,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  final color = timeLeft <= 10 ? Colors.red : AppColors.primary;
  final progress = timeLeft / 60;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    decoration: BoxDecoration(
      color: isDark ? AppColors.darkGrey2 : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.25),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 10,
          ),
        ),
        const SizedBox(height: 12),

        // Stat values
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildMiniStat('⏱ Time', '$timeLeft s', color),
            _buildMiniStat(
              '⭐ Score',
              '$score / $totalPairs',
              AppColors.singlePlayer,
            ),
            _buildMiniStat('🌀 Steps', '$steps', AppColors.localMultiplayer),
          ],
        ),
      ],
    ),
  );
}

Widget _buildMiniStat(String label, String value, Color color) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: color.withOpacity(0.8),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    ],
  );
}

Widget buildTimerSection(int timeLeft, BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  final color = timeLeft <= 10 ? Colors.red : AppColors.primary;
  final double progress = timeLeft / 60;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: isDarkMode ? AppColors.darkGrey2 : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.4),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      children: [
        // Circular Time Left
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor:
                    isDarkMode ? Colors.grey[800] : Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              '$timeLeft',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(width: 20),
        // Time Label & Progress
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '⏱ Time Left',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.white70 : Colors.grey[800],
                ),
              ),
              const SizedBox(height: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:
                      isDarkMode
                          ? Colors.grey[700]!.withOpacity(0.3)
                          : Colors.grey[300],
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        colors:
                            timeLeft <= 10
                                ? [Colors.redAccent, Colors.red]
                                : [AppColors.primary, AppColors.secondary],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildScoreAndSteps(
  int score,
  int totalPairs,
  int steps,
  BuildContext context,
) {
  return Row(
    children: [
      Expanded(
        child: _buildStatCard(
          icon: Icons.star_rounded,
          label: 'Score',
          value: '$score / $totalPairs',
          color: AppColors.singlePlayer,
          context: context,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: _buildStatCard(
          icon: Icons.local_fire_department,
          label: 'Steps',
          value: '$steps',
          color: AppColors.localMultiplayer,
          context: context,
        ),
      ),
    ],
  );
}

Widget _buildStatCard({
  required IconData icon,
  required String label,
  required String value,
  required Color color,
  required BuildContext context,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: isDark ? AppColors.darkGrey2 : Colors.white.withOpacity(0.9),
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white54 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.grey[900],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// -----------------------End of Single Player Game-----------------------

// ! -----------------------Online Game-----------------------
Widget buildConnectionStatus(
  bool connectionTimedOut,
  VoidCallback connectToServer,
  BuildContext context,
) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'Connecting to server...',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDarkMode ? Colors.orange[100] : Colors.black,
        ),
      ),
      const SizedBox(height: 20),
      if (!connectionTimedOut)
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isDarkMode ? Colors.orange[300]! : const Color(0xFFFF9800),
          ),
        )
      else ...[
        buildButton2(
          'Retry Connection',
          Icons.refresh,
          isDarkMode ? Colors.orange[300]! : const Color(0xFFFF9800),
          connectToServer,
          context,
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Sometimes there might be issues because of free deployment of the socket. Please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ),
      ],
    ],
  );
}

Widget buildLobbyArea(
  TextEditingController roomIdController,
  String roomId,
  VoidCallback createRoom,
  VoidCallback joinRoom,
  bool isWaiting,
  BuildContext context,
) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildButton2(
        'Create Room',
        Icons.add,
        isDarkMode ? Colors.orange[300]! : const Color(0xFFFF9800),
        createRoom,
        context,
      ),
      const SizedBox(height: 20),
      TextField(
        controller: roomIdController,
        decoration: InputDecoration(
          labelText: 'Room ID',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.orange[300]! : const Color(0xFFFF9800),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.orange[400]! : const Color(0xFFFF5722),
              width: 2,
            ),
          ),
          filled: true,
          fillColor: isDarkMode ? Colors.grey[900] : Colors.white,
          labelStyle: TextStyle(
            color: isDarkMode ? Colors.orange[100] : Colors.grey[700],
          ),
        ),
        style: TextStyle(color: isDarkMode ? Colors.orange[100] : Colors.black),
      ),
      const SizedBox(height: 20),
      buildButton2(
        'Join Room',
        Icons.login,
        isDarkMode ? Colors.orange[400]! : const Color(0xFFFF5722),
        joinRoom,
        context,
      ),
      if (roomId.isNotEmpty)
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Room ID: $roomId',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.orange[100] : Colors.black,
            ),
          ),
        ),
      if (isWaiting)
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            'Waiting for opponent...',
            style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: isDarkMode ? Colors.orange[200] : Colors.black54,
            ),
          ),
        ),
    ],
  );
}

Widget buildButton2(
  String text,
  IconData icon,
  Color color,
  VoidCallback onPressed,
  BuildContext context,
) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Container(
    width: 250,
    height: 60,
    decoration: BoxDecoration(
      color: isDarkMode ? Colors.grey[850] : color,
      borderRadius: BorderRadius.circular(12),
      border: isDarkMode ? Border.all(color: color, width: 2) : null,
      boxShadow: [
        BoxShadow(
          color:
              isDarkMode
                  ? Colors.black.withOpacity(0.3)
                  : color.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: isDarkMode ? color : Colors.white),
              const SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: isDarkMode ? color : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildPlayerCards2(
  int scorePlayer1,
  int scorePlayer2,
  int currentPlayer,
  BuildContext context,
) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Row(
    children: [
      Expanded(
        child: CompactPlayerCardOnline(
          player: 'Player 1',
          score: scorePlayer1,
          isActive: currentPlayer == 1,
          color: isDarkMode ? Colors.orange[300]! : const Color(0xFFFF9800),
          isDarkMode: isDarkMode,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: CompactPlayerCardOnline(
          player: 'Player 2',
          score: scorePlayer2,
          isActive: currentPlayer == 2,
          color: isDarkMode ? Colors.orange[400]! : const Color(0xFFFF5722),
          isDarkMode: isDarkMode,
        ),
      ),
    ],
  );
}

Widget buildTurnIndicator(bool isMyTurn, BuildContext context) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color:
          isDarkMode
              ? Colors.grey[850]
              : (isMyTurn ? const Color(0xFFFF9800) : const Color(0xFFFF5722)),
      borderRadius: BorderRadius.circular(12),
      border:
          isDarkMode
              ? Border.all(
                color: isMyTurn ? Colors.orange[300]! : Colors.orange[100]!,
                width: 2,
              )
              : null,
      boxShadow: [
        BoxShadow(
          color:
              isDarkMode
                  ? Colors.black.withOpacity(0.4)
                  : Colors.black.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      isMyTurn ? 'Your Turn' : 'Opponent\'s Turn',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color:
            isDarkMode
                ? (isMyTurn ? Colors.orange[300] : Colors.orange[100])
                : Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
  );
}
