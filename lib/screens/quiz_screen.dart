import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/app_colors.dart';
import '../widgets/option_card.dart';
import '../widgets/soft_button.dart';
import '../providers/history_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  final String userName;
  const QuizScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final textColor = isDark ? AppColors.textLightDark : AppColors.textDark;
    final progressBg = isDark ? AppColors.cardDark : AppColors.cream;

    final currentQuestion = quizProvider.currentQuestion;
    final timeLeft = quizProvider.timeLeft;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          'Soal ${quizProvider.currentQuestionIndex + 1} dari ${quizProvider.quizQuestions.length}',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => themeProvider.toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: quizProvider.progress,
                  minHeight: 8,
                  backgroundColor: progressBg,
                  color: AppColors.peachDark,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Sisa Waktu:', style: TextStyle(fontSize: 14, color: textColor)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: timeLeft <= 5
                          ? Colors.red.withValues(alpha: 0.2)
                          : AppColors.peach.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '⏱ $timeLeft s',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: timeLeft <= 5 ? Colors.red : AppColors.peachDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          currentQuestion.imagePath,
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: double.infinity,
                            height: 180,
                            color: progressBg,
                            child: Icon(Icons.broken_image, size: 50, color: textColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        currentQuestion.questionText,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: textColor, height: 1.3),
                      ),
                      const SizedBox(height: 24),
                      ...List.generate(currentQuestion.options.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OptionCard(
                            text: currentQuestion.options[index],
                            index: index,
                            selectedIndex: quizProvider.selectedOptionIndex,
                            correctIndex: currentQuestion.correctAnswerIndex,
                            isAnswered: quizProvider.isAnswered,
                            onTap: () => quizProvider.checkAnswer(index),
                          ),
                        );
                      }),
                      if (quizProvider.isAnswered) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.cardDark : AppColors.cream,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.peachDark),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    quizProvider.selectedOptionIndex == currentQuestion.correctAnswerIndex
                                        ? Icons.check_circle
                                        : Icons.cancel,
                                    color: quizProvider.selectedOptionIndex == currentQuestion.correctAnswerIndex
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    quizProvider.selectedOptionIndex == currentQuestion.correctAnswerIndex
                                        ? 'Jawaban Benar!'
                                        : 'Jawaban Salah',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                currentQuestion.explanation,
                                style: TextStyle(fontSize: 13, color: textColor, height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SoftButton(
                label: quizProvider.currentQuestionIndex == quizProvider.quizQuestions.length - 1
                    ? 'Selesai'
                    : 'Selanjutnya',
                onPressed: () {
                  if (!quizProvider.isAnswered) return;

                  if (quizProvider.currentQuestionIndex == quizProvider.quizQuestions.length - 1) {
                    final finalScore = quizProvider.score;
                    final totalQuestions = quizProvider.quizQuestions.length;
                    final category = quizProvider.currentCategory;
                    final wrongQs = List<Question>.from(quizProvider.wrongQuestions);

                    Provider.of<HistoryProvider>(context, listen: false).addHistory(
                      userName,
                      category,
                      finalScore,
                      totalQuestions,
                      wrongQs,
                    );

                    quizProvider.nextQuestion();

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultScreen(
                          userName: userName,
                          score: finalScore,
                          totalQuestions: totalQuestions,
                          category: category,
                        ),
                      ),
                    );
                  } else {
                    quizProvider.nextQuestion();
                  }
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}