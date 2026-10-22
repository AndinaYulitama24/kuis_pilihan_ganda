import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isFinished = false;

  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isFinished => _isFinished;

  Question get currentQuestion => dummyQuestions[_currentQuestionIndex];
  double get progress => (_currentQuestionIndex + 1) / dummyQuestions.length;

  void checkAnswer(int index) {
    _selectedOptionIndex = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (_selectedOptionIndex == null) return;

    if (_selectedOptionIndex == currentQuestion.correctAnswerIndex) {
      _score++;
    }

    if (_currentQuestionIndex < dummyQuestions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
    } else {
      _isFinished = true;
    }
    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedOptionIndex = null;
    _isFinished = false;
    notifyListeners();
  }
}