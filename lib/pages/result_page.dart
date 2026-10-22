import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // IMPORT BARU
import '../theme/app_colors.dart';
import '../widgets/soft_button.dart';
import '../providers/quiz_provider.dart'; // IMPORT BARU

class ResultPage extends StatelessWidget {
  final String userName;
  final int score;
  final int totalQuestions;

  const ResultPage({
    super.key,
    required this.userName,
    required this.score,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.width > 600;
    final horizontalPadding = isTablet ? 80.0 : 28.0;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: const BoxDecoration(
                      color: AppColors.peach,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.emoji_events_rounded,
                      size: 64,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Hebat, $userName!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isTablet ? 32 : 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Kamu telah menyelesaikan kuis ini.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.cream,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.peach,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Skor Akhir',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.textLight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$score / $totalQuestions',
                          style: TextStyle(
                            fontSize: isTablet ? 64 : 48,
                            fontWeight: FontWeight.bold,
                            color: AppColors.peachDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  SoftButton(
                    label: 'Main Lagi',
                    onPressed: () {
                      // RESET STATE DARI PROVIDER SEBELUM KEMBALI
                      Provider.of<QuizProvider>(context, listen: false).resetQuiz();
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}