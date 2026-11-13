import 'package:flutter/material.dart';
import '../models/question_model.dart';

class QuizProvider extends ChangeNotifier {
  String _userName = '';
  final List<Question> _questions = List.unmodifiable(QuestionBank.questions);
  int _currentIndex = 0;
  final Map<int, int> _userAnswers = {}; // {questionIndex: selectedOptionIndex}
  bool _isSubmitted = false;

  // Getters
  String get userName => _userName;
  List<Question> get questions => _questions;
  int get totalQuestions => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  Map<int, int> get userAnswers => Map.unmodifiable(_userAnswers);
  bool get isSubmitted => _isSubmitted;

  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;
  double get progress => (_currentIndex + 1) / _questions.length;

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

  String get performanceStatus {
    final s = score;
    if (s >= 90) return 'Luar Biasa! 🏆';
    if (s >= 75) return 'Sangat Bagus! 🎉';
    if (s >= 60) return 'Bagus, Cukup Memuaskan! 👍';
    return 'Perlu Belajar Lagi! 💪';
  }

  // Setters & Actions
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
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
    _currentIndex = 0;
    _userAnswers.clear();
    _isSubmitted = false;
    notifyListeners();
  }
}
