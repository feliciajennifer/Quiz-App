import 'package:flutter/material.dart';

class QuizModel with ChangeNotifier {
  String _userName = '';
  List<int?> _userAnswers = [];
  List<Map<String, dynamic>> _questions = [];

  String get userName => _userName;
  List<int?> get userAnswers => _userAnswers;
  List<Map<String, dynamic>> get questions => _questions;

  set userName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setQuestions(List<Map<String, dynamic>> questionsList) {
    _questions = questionsList;
    _userAnswers = List<int?>.filled(questionsList.length, null);
    notifyListeners();
  }

  void setAnswer(int questionIndex, int answerIndex) {
    _userAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  int getScore() {
    int score = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_userAnswers[i] == _questions[i]['correctAnswer']) {
        score++;
      }
    }
    return score;
  }

  void resetQuiz() {
    _userName = '';
    _userAnswers = [];
    _questions = [];
    notifyListeners();
  }
}