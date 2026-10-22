import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  List<Question> _quizQuestions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  bool _isFinished = false;

  Timer? _timer;
  int _timeLeft = 15;
  static const int timeLimit = 15;

  final List<Question> _wrongQuestions = [];

  List<Question> get quizQuestions => _quizQuestions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  int? get selectedOptionIndex => _selectedOptionIndex;
  bool get isAnswered => _isAnswered;
  bool get isFinished => _isFinished;
  int get timeLeft => _timeLeft;
  List<Question> get wrongQuestions => _wrongQuestions;
  String get currentCategory => _quizQuestions.isNotEmpty ? _quizQuestions.first.category : "";

  Question get currentQuestion => _quizQuestions[_currentQuestionIndex];

  // PERBAIKAN: Progress dinamis berdasarkan jumlah soal
  double get progress => _quizQuestions.isEmpty ? 0 : (_currentQuestionIndex + 1) / _quizQuestions.length;

  void startQuiz(String category) {
    final categoryQuestions = allQuestions.where((q) => q.category == category).toList();
    categoryQuestions.shuffle(Random());
    _quizQuestions = categoryQuestions.take(5).toList();

    _currentQuestionIndex = 0;
    _score = 0;
    _selectedOptionIndex = null;
    _isAnswered = false;
    _isFinished = false;
    _wrongQuestions.clear();

    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timeLeft = timeLimit;
    _isAnswered = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _isAnswered = true;
        if (!_wrongQuestions.contains(currentQuestion)) {
          _wrongQuestions.add(currentQuestion);
        }
        notifyListeners();
      }
    });
  }

  void checkAnswer(int index) {
    if (_isAnswered) return;
    _selectedOptionIndex = index;
    _isAnswered = true;
    _timer?.cancel();

    if (index == currentQuestion.correctAnswerIndex) {
      _score++;
    } else {
      if (!_wrongQuestions.contains(currentQuestion)) {
        _wrongQuestions.add(currentQuestion);
      }
    }
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      _currentQuestionIndex++;
      _selectedOptionIndex = null;
      _startTimer();
    } else {
      _isFinished = true;
      _timer?.cancel();
    }
    notifyListeners();
  }

  void resetQuiz() {
    _timer?.cancel();
    _quizQuestions = [];
    _currentQuestionIndex = 0;
    _score = 0;
    _selectedOptionIndex = null;
    _isAnswered = false;
    _isFinished = false;
    _timeLeft = timeLimit;
    _wrongQuestions.clear();
    notifyListeners();
  }

  int get finalScore100 => _quizQuestions.isEmpty ? 0 : (_score / _quizQuestions.length * 100).round();

  String get evaluationMessage {
    int finalScore = finalScore100;
    if (finalScore >= 80) return 'Luar biasa! Pengetahuanmu sangat baik.';
    if (finalScore >= 60) return 'Bagus! Sedikit lagi menuju sempurna.';
    return 'Jangan menyerah! Teruslah belajar dan coba lagi.';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}