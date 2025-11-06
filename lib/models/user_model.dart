import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String _name = '';
  int _currentScore = 0;
  List<Map<String, dynamic>> _quizHistory = [];

  String get name => _name;
  int get currentScore => _currentScore;
  List<Map<String, dynamic>> get quizHistory => _quizHistory;

  set name(String newName) {
    _name = newName;
    notifyListeners();
  }

  void addQuizResult(Map<String, dynamic> result) {
    _quizHistory.add(result);
    notifyListeners();
  }

  void setCurrentScore(int score) {
    _currentScore = score;
    notifyListeners();
  }

  void clearUser() {
    _name = '';
    _currentScore = 0;
    _quizHistory = [];
    notifyListeners();
  }

  bool get isLoggedIn => _name.isNotEmpty;
}