import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';
import '../services/database_service.dart';

enum QuizState { notStarted, loading, inProgress, completed, reviewing, error }

class QuizProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  QuizSession? _currentSession;
  QuizState _state = QuizState.notStarted;
  Timer? _timer;
  int _timeElapsed = 0; // in seconds
  int? _selectedAnswerIndex;
  bool _showFeedback = false;
  String? _errorMessage;

  // Getters
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion => 
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;
  QuizSession? get currentSession => _currentSession;
  QuizState get state => _state;
  int get timeElapsed => _timeElapsed;
  int? get selectedAnswerIndex => _selectedAnswerIndex;
  bool get showFeedback => _showFeedback;
  bool get isLastQuestion => _currentQuestionIndex >= _questions.length - 1;
  int get totalQuestions => _questions.length;
  int get questionsAnswered => _currentSession?.results.length ?? 0;
  String? get errorMessage => _errorMessage;

  String get formattedTime {
    final minutes = _timeElapsed ~/ 60;
    final seconds = _timeElapsed % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progress => 
      _questions.isNotEmpty ? (_currentQuestionIndex + 1) / _questions.length : 0.0;

  Future<void> loadQuestions() async {
    _state = QuizState.loading;
    _errorMessage = null;
    notifyListeners();
    
    try {
      _questions = await _databaseService.getAllQuestions();
      
      if (_questions.isEmpty) {
        _state = QuizState.error;
        _errorMessage = 'No questions found. Please check your internet connection and try again.';
      } else {
        _questions.shuffle(); // Randomize question order
        _state = QuizState.notStarted;
      }
      
      notifyListeners();
    } catch (e) {
      _state = QuizState.error;
      _errorMessage = 'Failed to load questions. Please check your internet connection and try again.';
      debugPrint('Error loading questions: $e');
      notifyListeners();
    }
  }

  void startQuiz() {
    if (_questions.isEmpty) return;
    
    _state = QuizState.inProgress;
    _currentQuestionIndex = 0;
    _timeElapsed = 0;
    _selectedAnswerIndex = null;
    _showFeedback = false;
    
    _currentSession = QuizSession(
      results: [],
      startTime: DateTime.now(),
      totalQuestions: _questions.length,
    );

    _startTimer();
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeElapsed++;
      notifyListeners();
    });
  }

  void selectAnswer(int answerIndex) {
    if (_state != QuizState.inProgress || _showFeedback) return;
    
    _selectedAnswerIndex = answerIndex;
    _showFeedback = true;
    
    final question = currentQuestion!;
    final isCorrect = answerIndex == question.correctAnswerIndex;
    
    final result = QuizResult(
      questionId: question.id,
      selectedAnswerIndex: answerIndex,
      isCorrect: isCorrect,
      answeredAt: DateTime.now(),
    );

    _currentSession!.results.add(result);
    notifyListeners();
  }

  void nextQuestion() {
    if (_state != QuizState.inProgress) return;

    _selectedAnswerIndex = null;
    _showFeedback = false;

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      _completeQuiz();
    }
    
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      _selectedAnswerIndex = null;
      _showFeedback = false;
      
      // Remove the result for this question if going back
      if (_currentSession != null) {
        final questionId = currentQuestion!.id;
        _currentSession!.results.removeWhere((r) => r.questionId == questionId);
      }
      
      notifyListeners();
    }
  }

  void _completeQuiz() {
    _timer?.cancel();
    _state = QuizState.completed;
    
    if (_currentSession != null) {
      _currentSession = QuizSession(
        results: _currentSession!.results,
        startTime: _currentSession!.startTime,
        endTime: DateTime.now(),
        totalQuestions: _currentSession!.totalQuestions,
      );
      
      // Save quiz session to database
      _databaseService.saveQuizSession(_currentSession!);
    }
    
    notifyListeners();
  }

  void restartQuiz() {
    _timer?.cancel();
    _state = QuizState.notStarted;
    _currentQuestionIndex = 0;
    _timeElapsed = 0;
    _selectedAnswerIndex = null;
    _showFeedback = false;
    _currentSession = null;
    
    // Shuffle questions again for variety
    _questions.shuffle();
    notifyListeners();
  }

  void startReview() {
    _state = QuizState.reviewing;
    _currentQuestionIndex = 0;
    _selectedAnswerIndex = null;
    _showFeedback = false;
    notifyListeners();
  }

  void reviewQuestion(int questionIndex) {
    if (_state != QuizState.reviewing) return;
    
    _currentQuestionIndex = questionIndex;
    _selectedAnswerIndex = null;
    _showFeedback = false;
    
    // Find the user's answer for this question
    if (_currentSession != null) {
      final questionId = _questions[questionIndex].id;
      final result = _currentSession!.results
          .where((r) => r.questionId == questionId)
          .firstOrNull;
      
      if (result != null) {
        _selectedAnswerIndex = result.selectedAnswerIndex;
        _showFeedback = true;
      }
    }
    
    notifyListeners();
  }

  void exitReview() {
    _state = QuizState.completed;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}