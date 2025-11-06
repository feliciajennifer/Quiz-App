import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String _name = '';
  int _currentScore = 0;
  int _totalQuizzes = 0;
  int _level = 1;
  List<Map<String, dynamic>> _quizHistory = [];

  String get name => _name;
  int get currentScore => _currentScore;
  int get totalQuizzes => _totalQuizzes;
  int get level => _level;
  List<Map<String, dynamic>> get quizHistory => _quizHistory;

  set name(String newName) {
    _name = newName;
    notifyListeners();
  }

  void addQuizResult(Map<String, dynamic> result) {
    _quizHistory.add(result);
    _totalQuizzes++;
    
    final score = result['score'] is int ? result['score'] as int : 0;
    _currentScore += score;
    
    _level = (_currentScore ~/ 100) + 1;
    
    notifyListeners();
  }

  void setCurrentScore(int score) {
    _currentScore = score;
    notifyListeners();
  }

  void clearUser() {
    _name = '';
    _currentScore = 0;
    _totalQuizzes = 0;
    _level = 1;
    _quizHistory = [];
    notifyListeners();
  }

  bool get isLoggedIn => _name.isNotEmpty;

  // Method untuk mendapatkan progress user
  Map<String, dynamic> getUserStats() {
    return {
      'name': _name,
      'score': _currentScore,
      'quizzesCompleted': _totalQuizzes,
      'level': _level,
      'nextLevelPoints': (_level * 100) - _currentScore,
    };
  }
}