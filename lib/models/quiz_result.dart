class QuizResult {
  final int questionId;
  final int selectedAnswerIndex;
  final bool isCorrect;
  final DateTime answeredAt;

  QuizResult({
    required this.questionId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.answeredAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      questionId: json['questionId'],
      selectedAnswerIndex: json['selectedAnswerIndex'],
      isCorrect: json['isCorrect'],
      answeredAt: DateTime.parse(json['answeredAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'selectedAnswerIndex': selectedAnswerIndex,
      'isCorrect': isCorrect,
      'answeredAt': answeredAt.toIso8601String(),
    };
  }
}

class QuizSession {
  final List<QuizResult> results;
  final DateTime startTime;
  final DateTime? endTime;
  final int totalQuestions;

  QuizSession({
    required this.results,
    required this.startTime,
    this.endTime,
    required this.totalQuestions,
  });

  int get correctAnswers => results.where((r) => r.isCorrect).length;
  int get incorrectAnswers => results.where((r) => !r.isCorrect).length;
  double get scorePercentage => (correctAnswers / totalQuestions) * 100;
  
  Duration get timeTaken {
    if (endTime != null) {
      return endTime!.difference(startTime);
    }
    return DateTime.now().difference(startTime);
  }

  int get timeElapsed {
    return timeTaken.inSeconds;
  }

  bool get isCompleted => results.length == totalQuestions;

  factory QuizSession.fromJson(Map<String, dynamic> json) {
    return QuizSession(
      results: (json['results'] as List)
          .map((r) => QuizResult.fromJson(r))
          .toList(),
      startTime: DateTime.parse(json['startTime']),
      endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
      totalQuestions: json['totalQuestions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((r) => r.toJson()).toList(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'totalQuestions': totalQuestions,
    };
  }
}