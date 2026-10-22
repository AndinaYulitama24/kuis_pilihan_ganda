import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/question.dart';
import '../widgets/option_card.dart';
import '../widgets/soft_button.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final String userName;

  const QuizPage({super.key, required this.userName});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;

  void _checkAnswer(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  void _nextQuestion() {
    if (_selectedOptionIndex == null) return;

    if (_selectedOptionIndex ==
        dummyQuestions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            userName: widget.userName,
            score: _score,
            totalQuestions: dummyQuestions.length,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = dummyQuestions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / dummyQuestions.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: Text(
          'Soal ${_currentQuestionIndex + 1} dari ${dummyQuestions.length}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
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
                  value: progress,
                  minHeight: 8,
                  backgroundColor: AppColors.cream,
                  color: AppColors.peachDark,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                currentQuestion.questionText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 32),
              ...List.generate(currentQuestion.options.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: OptionCard(
                    text: currentQuestion.options[index],
                    isSelected: _selectedOptionIndex == index,
                    onTap: () => _checkAnswer(index),
                  ),
                );
              }),
              const Spacer(),
              SoftButton(
                label: _currentQuestionIndex == dummyQuestions.length - 1
                    ? 'Selesai'
                    : 'Selanjutnya',
                onPressed: _selectedOptionIndex == null ? () {} : _nextQuestion,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}