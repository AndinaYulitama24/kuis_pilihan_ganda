import 'question.dart';

class HistoryModel {
  final String userName;
  final String category;
  final int score;
  final int totalQuestions;
  final DateTime date;
  final List<Question> wrongQuestions;

  HistoryModel({
    required this.userName,
    required this.category,
    required this.score,
    required this.totalQuestions,
    required this.date,
    required this.wrongQuestions,
  });
}