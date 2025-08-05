import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/answer_feedback.dart';
import 'results_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().startQuiz();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        if (quizProvider.state == QuizState.completed) {
          return const ResultsScreen();
        }

        final currentQuestion = quizProvider.currentQuestion;
        if (currentQuestion == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Question ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
            ),
            actions: [
              // Timer display
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        quizProvider.formattedTime,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: quizProvider.progress,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Question card
                      Expanded(
                        child: QuestionCard(
                          question: currentQuestion,
                          selectedAnswerIndex: quizProvider.selectedAnswerIndex,
                          showFeedback: quizProvider.showFeedback,
                          onAnswerSelected: (index) {
                            quizProvider.selectAnswer(index);
                          },
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Feedback section
                      if (quizProvider.showFeedback)
                        AnswerFeedback(
                          question: currentQuestion,
                          selectedAnswerIndex: quizProvider.selectedAnswerIndex!,
                        ),
                      
                      const SizedBox(height: 16),
                      
                      // Navigation buttons
                      Row(
                        children: [
                          // Previous button
                          if (quizProvider.currentQuestionIndex > 0)
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: quizProvider.showFeedback 
                                    ? null 
                                    : () => quizProvider.previousQuestion(),
                                icon: const Icon(Icons.arrow_back),
                                label: const Text('Previous'),
                              ),
                            ),
                          
                          if (quizProvider.currentQuestionIndex > 0)
                            const SizedBox(width: 16),
                          
                          // Next/Finish button
                          Expanded(
                            flex: quizProvider.currentQuestionIndex > 0 ? 1 : 2,
                            child: ElevatedButton.icon(
                              onPressed: quizProvider.showFeedback
                                  ? () {
                                      if (quizProvider.isLastQuestion) {
                                        quizProvider.nextQuestion(); // This will complete the quiz
                                      } else {
                                        quizProvider.nextQuestion();
                                      }
                                    }
                                  : null,
                              icon: Icon(
                                quizProvider.isLastQuestion 
                                    ? Icons.check 
                                    : Icons.arrow_forward,
                              ),
                              label: Text(
                                quizProvider.isLastQuestion 
                                    ? 'Finish Quiz' 
                                    : 'Next Question',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}