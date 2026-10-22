import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/history_model.dart';
import '../models/question.dart';

class HistoryProvider extends ChangeNotifier {
  List<HistoryModel> _history = [];

  List<HistoryModel> get history => _history;

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('history');
    if (data != null) {
      try {
        final List decoded = jsonDecode(data);
        _history = decoded.map((e) {
          List<Question> wrongQs = [];
          if (e['wrongQuestions'] != null) {
            wrongQs = (e['wrongQuestions'] as List).map((q) => Question(
              questionText: q['questionText'],
              options: List<String>.from(q['options']),
              correctAnswerIndex: q['correctAnswerIndex'],
              category: q['category'],
              imagePath: q['imagePath'],
              explanation: q['explanation'],
            )).toList();
          }

          return HistoryModel(
            userName: e['userName'] ?? 'Pengguna',
            category: e['category'],
            score: e['score'],
            totalQuestions: e['totalQuestions'],
            date: DateTime.parse(e['date']),
            wrongQuestions: wrongQs,
          );
        }).toList();
        notifyListeners();
      } catch (err) {
        await prefs.remove('history');
        _history = [];
        notifyListeners();
      }
    }
  }

  Future<void> addHistory(String userName, String category, int score, int total, List<Question> wrongQs) async {
    final newHistory = HistoryModel(
      userName: userName,
      category: category,
      score: score,
      totalQuestions: total,
      date: DateTime.now(),
      wrongQuestions: wrongQs,
    );
    _history.insert(0, newHistory);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> deleteHistory(int index) async {
    _history.removeAt(index);
    await _saveToPrefs();
    notifyListeners();
  }

  Future<void> clearHistory() async {
    _history.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('history');
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final List encoded = _history.map((e) => {
      'userName': e.userName,
      'category': e.category,
      'score': e.score,
      'totalQuestions': e.totalQuestions,
      'date': e.date.toIso8601String(),
      'wrongQuestions': e.wrongQuestions.map((q) => {
        'questionText': q.questionText,
        'options': q.options,
        'correctAnswerIndex': q.correctAnswerIndex,
        'category': q.category,
        'imagePath': q.imagePath,
        'explanation': q.explanation,
      }).toList(),
    }).toList();
    await prefs.setString('history', jsonEncode(encoded));
  }
}