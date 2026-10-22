import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // IMPORT BARU
import '../theme/app_colors.dart';
import '../widgets/option_card.dart';
import '../widgets/soft_button.dart';
import '../providers/quiz_provider.dart'; // IMPORT BARU
import '../models/question.dart'; // IMPORT BARU
import 'result_page.dart';

class QuizPage extends StatelessWidget { // BERUBAH JADI STATELESS
  final String userName;

  const QuizPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);

    // Jika kuis sudah selesai, pindah ke halaman hasil
    if (quizProvider.isFinished) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              userName: userName,
              score: quizProvider.score,
              totalQuestions: dummyQuestions.length,
            ),
          ),
        );
      });
    }

    final isTablet = MediaQuery.of(context).size.width > 600;
    final horizontalPadding = isTablet ? 80.0 : 28.0;
    final questionSize = isTablet ? 28.0 : 22.0;
    final currentQuestion = quizProvider.currentQuestion;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: Text(
          'Soal ${quizProvider.currentQuestionIndex + 1} dari ${dummyQuestions.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: quizProvider.progress,
                      minHeight: 8,
                      backgroundColor: AppColors.cream,
                      color: AppColors.peachDark,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    currentQuestion.questionText,
                    style: TextStyle(
                      fontSize: questionSize,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: ListView.builder(
                      itemCount: currentQuestion.options.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OptionCard(
                            text: currentQuestion.options[index],
                            isSelected: quizProvider.selectedOptionIndex == index,
                            onTap: () => quizProvider.checkAnswer(index),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  SoftButton(
                    label: quizProvider.currentQuestionIndex == dummyQuestions.length - 1
                        ? 'Selesai'
                        : 'Selanjutnya',
                    onPressed: quizProvider.selectedOptionIndex == null
                        ? () {}
                        : () => quizProvider.nextQuestion(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}