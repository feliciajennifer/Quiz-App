import 'package:flutter/material.dart';

class QuizModel with ChangeNotifier {
  String _userName = '';
  List<int?> _userAnswers = [];
  Map<String, dynamic>? _currentQuiz;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  String get userName => _userName;
  List<int?> get userAnswers => _userAnswers;
  Map<String, dynamic>? get currentQuiz => _currentQuiz;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  set userName(String name) {
    _userName = name;
    notifyListeners();
  }

  void setCurrentQuiz(Map<String, dynamic> quiz) {
    _currentQuiz = quiz;
    _userAnswers = List<int?>.filled(quiz['questions'].length, null);
    notifyListeners();
  }

  void setAnswer(int questionIndex, int answerIndex) {
    if (_userAnswers.isNotEmpty && questionIndex < _userAnswers.length) {
      _userAnswers[questionIndex] = answerIndex;
      notifyListeners();
    }
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  int getScore() {
    if (_currentQuiz == null) return 0;
    int score = 0;
    for (int i = 0; i < _currentQuiz!['questions'].length; i++) {
      if (i < _userAnswers.length && 
          _userAnswers[i] == _currentQuiz!['questions'][i]['correctAnswer']) {
        score++;
      }
    }
    return score;
  }

  void resetQuiz() {
    _userAnswers = [];
    _currentQuiz = null;
    notifyListeners();
  }

  bool get hasCurrentQuiz => _currentQuiz != null;
}