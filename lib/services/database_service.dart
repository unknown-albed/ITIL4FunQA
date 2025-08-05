import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import '../models/question.dart';
import '../models/quiz_result.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;
  List<Question>? _webQuestions; // Cache for web platform

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'itil4_quiz.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create questions table
    await db.execute('''
      CREATE TABLE questions(
        id INTEGER PRIMARY KEY,
        questionText TEXT NOT NULL,
        options TEXT NOT NULL,
        correctAnswerIndex INTEGER NOT NULL,
        explanation TEXT NOT NULL
      )
    ''');

    // Create quiz_sessions table
    await db.execute('''
      CREATE TABLE quiz_sessions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        startTime TEXT NOT NULL,
        endTime TEXT,
        totalQuestions INTEGER NOT NULL,
        results TEXT NOT NULL
      )
    ''');

    // Load initial questions from assets
    await _loadInitialQuestions(db);
  }

  Future<void> _loadInitialQuestions(Database db) async {
    try {
      final String questionsJson = await rootBundle.loadString('assets/data/questions.json');
      final Map<String, dynamic> data = json.decode(questionsJson);
      final List<dynamic> questionsData = data['questions'];

      for (var questionData in questionsData) {
        final question = Question.fromJson(questionData);
        await db.insert('questions', {
          'id': question.id,
          'questionText': question.questionText,
          'options': json.encode(question.options),
          'correctAnswerIndex': question.correctAnswerIndex,
          'explanation': question.explanation,
        });
      }
    } catch (e) {
      // Error loading initial questions - could show user-friendly error message
      debugPrint('Error loading initial questions: $e');
    }
  }

  // Web-compatible question loading
  Future<List<Question>> _loadQuestionsFromAssets() async {
    try {
      final String questionsJson = await rootBundle.loadString('assets/data/questions.json');
      final Map<String, dynamic> data = json.decode(questionsJson);
      final List<dynamic> questionsData = data['questions'];

      return questionsData.map((questionData) => Question.fromJson(questionData)).toList();
    } catch (e) {
      debugPrint('Error loading questions from assets: $e');
      return [];
    }
  }

  Future<List<Question>> getAllQuestions() async {
    // For web platform, load directly from assets
    if (kIsWeb) {
      if (_webQuestions == null) {
        _webQuestions = await _loadQuestionsFromAssets();
      }
      return _webQuestions!;
    }

    // For mobile platforms, use SQLite
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('questions');

      return List.generate(maps.length, (i) {
        return Question(
          id: maps[i]['id'],
          questionText: maps[i]['questionText'],
          options: List<String>.from(json.decode(maps[i]['options'])),
          correctAnswerIndex: maps[i]['correctAnswerIndex'],
          explanation: maps[i]['explanation'],
        );
      });
    } catch (e) {
      debugPrint('Error loading questions from database: $e');
      // Fallback to assets for mobile if database fails
      return await _loadQuestionsFromAssets();
    }
  }

  Future<Question?> getQuestionById(int id) async {
    // For web platform, search in cached questions
    if (kIsWeb) {
      final questions = await getAllQuestions();
      try {
        return questions.firstWhere((q) => q.id == id);
      } catch (e) {
        return null;
      }
    }

    // For mobile platforms, use SQLite
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'questions',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return Question(
          id: maps[0]['id'],
          questionText: maps[0]['questionText'],
          options: List<String>.from(json.decode(maps[0]['options'])),
          correctAnswerIndex: maps[0]['correctAnswerIndex'],
          explanation: maps[0]['explanation'],
        );
      }
      return null;
    } catch (e) {
      debugPrint('Error getting question by ID: $e');
      return null;
    }
  }

  Future<void> saveQuizSession(QuizSession session) async {
    // For web platform, use local storage (simplified - just log for now)
    if (kIsWeb) {
      debugPrint('Quiz session completed: ${session.correctAnswers}/${session.totalQuestions} in ${session.timeElapsed}s');
      return;
    }

    // For mobile platforms, use SQLite
    try {
      final db = await database;
      await db.insert('quiz_sessions', {
        'startTime': session.startTime.toIso8601String(),
        'endTime': session.endTime?.toIso8601String(),
        'totalQuestions': session.totalQuestions,
        'results': json.encode(session.results.map((r) => r.toJson()).toList()),
      });
    } catch (e) {
      debugPrint('Error saving quiz session: $e');
    }
  }

  Future<List<QuizSession>> getQuizHistory() async {
    // For web platform, return empty for now (could implement with local storage)
    if (kIsWeb) {
      return [];
    }

    // For mobile platforms, use SQLite
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query(
        'quiz_sessions',
        orderBy: 'startTime DESC',
      );

      return List.generate(maps.length, (i) {
        final resultsJson = json.decode(maps[i]['results']) as List;
        final results = resultsJson.map((r) => QuizResult.fromJson(r)).toList();
        
        return QuizSession(
          startTime: DateTime.parse(maps[i]['startTime']),
          endTime: maps[i]['endTime'] != null ? DateTime.parse(maps[i]['endTime']) : null,
          totalQuestions: maps[i]['totalQuestions'],
          results: results,
        );
      });
    } catch (e) {
      debugPrint('Error loading quiz history: $e');
      return [];
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('quiz_sessions');
  }
}