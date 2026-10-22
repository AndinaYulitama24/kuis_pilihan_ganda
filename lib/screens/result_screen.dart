import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/soft_button.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final String userName;
  final int score;
  final int totalQuestions;
  final String category;

  const ResultScreen({
    super.key,
    required this.userName,
    required this.score,
    required this.totalQuestions,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.textLightDark : AppColors.textDark;
    final textMuted = isDark ? AppColors.textMutedDark : AppColors.textLight;
    final cardColor = isDark ? AppColors.cardDark : AppColors.cream;

    final score100 = (score / totalQuestions * 100).round();
    final wrongAnswersCount = totalQuestions - score;

    String evaluationMessage = 'Jangan menyerah! Teruslah belajar dan coba lagi.';

    if (score100 >= 80) {
      evaluationMessage = 'Luar biasa! Pengetahuanmu sangat baik.';
    } else if (score100 >= 60) {
      evaluationMessage = 'Bagus! Sedikit lagi menuju sempurna.';
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(color: AppColors.peach, shape: BoxShape.circle),
                  child: const Icon(Icons.emoji_events_rounded, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 32),
                Text('Hebat, $userName!', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 8),
                Text(evaluationMessage, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: textMuted)),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.peach, width: 1.5),
                  ),
                  child: Column(
                    children: [
                      Text('Nilai Akhir', style: TextStyle(fontSize: 16, color: textMuted, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text('$score100', style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: AppColors.peachDark)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          children: [
                            const Text('Benar', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            Text('$score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Column(
                          children: [
                            const Text('Salah', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                            Text('$wrongAnswersCount', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 48),
                SoftButton(
                  label: 'Kembali ke Beranda',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}