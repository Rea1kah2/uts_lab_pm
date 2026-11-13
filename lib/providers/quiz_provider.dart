import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  String _selectedCategory = 'all';
  List<Question> _questions = QuestionBank.getQuestionsByCategory('all');
  int _currentIndex = 0;
  final Map<int, int> _userAnswers = {}; // {questionIndex: selectedOptionIndex}
  bool _isSubmitted = false;

  // Getters
  String get userName => _userName;
  String get selectedCategory => _selectedCategory;
  List<Question> get questions => _questions;
  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  Map<int, int> get userAnswers => Map.unmodifiable(_userAnswers);
  bool get isSubmitted => _isSubmitted;

  String get selectedCategoryTitle {
    final cat = QuestionBank.categories.firstWhere(
      (c) => c.id == _selectedCategory,
      orElse: () => QuestionBank.categories.first,
    );
    return '${cat.icon} ${cat.title}';
  }

  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  double get progress =>
      _questions.isEmpty ? 0 : (_currentIndex + 1) / _questions.length;

  int? getSelectedAnswer(int questionIndex) => _userAnswers[questionIndex];
  bool isQuestionAnswered(int questionIndex) =>
      _userAnswers.containsKey(questionIndex);

  int get correctCount {
    int correct = 0;
    _userAnswers.forEach((qIndex, optIndex) {
      if (qIndex < _questions.length &&
          _questions[qIndex].correctAnswerIndex == optIndex) {
        correct++;
      }
    });
    return correct;
  }

  int get incorrectCount {
    int incorrect = 0;
    _userAnswers.forEach((qIndex, optIndex) {
      if (qIndex < _questions.length &&
          _questions[qIndex].correctAnswerIndex != optIndex) {
        incorrect++;
      }
    });
    return incorrect;
  }

  int get unansweredCount => _questions.length - _userAnswers.length;

  int get score {
    if (_questions.isEmpty) return 0;
    // Skala 100
    return ((correctCount / _questions.length) * 100).round();
  }

  /// Feedback skor yang casual, santai, dan dev-friendly (Anti AI-Slop)
  String get performanceStatus {
    final s = score;
    if (s == 100) return 'Suhu dev terdeteksi! Gak ada obat! 🔥';
    if (s >= 80) return 'Gokil cuy, pemahaman lo udah solid banget! 🚀';
    if (s >= 60) return 'Not bad! Tinggal poles dikit lagi auto senior ☕';
    return 'Santai, namanya juga belajar. Intip pembahasannya di bawah yuk! 💪';
  }

  // Setters & Actions
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  void setCategory(String categoryId) {
    if (_selectedCategory != categoryId) {
      _selectedCategory = categoryId;
      _questions = QuestionBank.getQuestionsByCategory(categoryId);
      _currentIndex = 0;
      _userAnswers.clear();
      _isSubmitted = false;
      notifyListeners();
    }
  }

  void selectAnswer(int optionIndex) {
    _userAnswers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void goToNext() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void goToPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  void submitQuiz() {
    _isSubmitted = true;
    notifyListeners();
  }

  void restartQuiz({bool keepUserName = true}) {
    if (!keepUserName) {
      _userName = '';
    }
    _questions = QuestionBank.getQuestionsByCategory(_selectedCategory);
    _currentIndex = 0;
    _userAnswers.clear();
    _isSubmitted = false;
    notifyListeners();
  }
}
