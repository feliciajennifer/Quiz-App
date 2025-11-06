import 'package:flutter/material.dart';

class QuizModel with ChangeNotifier {
  String _userName = '';
  List<int?> _userAnswers = [];
  Map<String, dynamic>? _currentQuiz;
  List<Map<String, dynamic>> _filteredQuizzes = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';

  String get userName => _userName;
  List<int?> get userAnswers => _userAnswers;
  Map<String, dynamic>? get currentQuiz => _currentQuiz;
  List<Map<String, dynamic>> get filteredQuizzes => _filteredQuizzes;
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
    _userAnswers[questionIndex] = answerIndex;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    _filterQuizzes();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _filterQuizzes();
    notifyListeners();
  }

  void _filterQuizzes() {
    // Implement filtering logic based on category and search query
    // This will be connected with quiz_data.dart
  }

  int getScore() {
    if (_currentQuiz == null) return 0;
    int score = 0;
    for (int i = 0; i < _currentQuiz!['questions'].length; i++) {
      if (_userAnswers[i] == _currentQuiz!['questions'][i]['correctAnswer']) {
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
}