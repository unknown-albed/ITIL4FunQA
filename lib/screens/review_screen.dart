import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/answer_feedback.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuizProvider>().startReview();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quizProvider, child) {
        final currentQuestion = quizProvider.currentQuestion;
        final session = quizProvider.currentSession;
        
        if (currentQuestion == null || session == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Find the user's result for this question
        final questionResult = session.results
            .where((r) => r.questionId == currentQuestion.id)
            .firstOrNull;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Review ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}',
            ),
            leading: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                quizProvider.exitReview();
                Navigator.of(context).pop();
              },
            ),
            actions: [
              // Question list button
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () => _showQuestionList(context, quizProvider),
                tooltip: 'Question List',
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
                          selectedAnswerIndex: questionResult?.selectedAnswerIndex,
                          showFeedback: true,
                          onAnswerSelected: null, // Disable selection in review mode
                          isReviewMode: true,
                        ),
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Always show feedback in review mode
                      if (questionResult != null)
                        AnswerFeedback(
                          question: currentQuestion,
                          selectedAnswerIndex: questionResult.selectedAnswerIndex,
                        ),
                      
                      const SizedBox(height: 16),
                      
                      // Navigation buttons
                      Row(
                        children: [
                          // Previous button
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: quizProvider.currentQuestionIndex > 0
                                  ? () => quizProvider.reviewQuestion(
                                        quizProvider.currentQuestionIndex - 1)
                                  : null,
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Previous'),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Next button
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: quizProvider.currentQuestionIndex < 
                                         quizProvider.totalQuestions - 1
                                  ? () => quizProvider.reviewQuestion(
                                        quizProvider.currentQuestionIndex + 1)
                                  : null,
                              icon: const Icon(Icons.arrow_forward),
                              label: const Text('Next'),
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

  void _showQuestionList(BuildContext context, QuizProvider quizProvider) {
    final session = quizProvider.currentSession;
    if (session == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question List',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            Flexible(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: quizProvider.totalQuestions,
                itemBuilder: (context, index) {
                  final question = quizProvider.questions[index];
                  final result = session.results
                      .where((r) => r.questionId == question.id)
                      .firstOrNull;
                  
                  final isCorrect = result?.isCorrect ?? false;
                  final isCurrent = index == quizProvider.currentQuestionIndex;
                  
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      quizProvider.reviewQuestion(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? Theme.of(context).colorScheme.primary
                            : isCorrect
                                ? Colors.green
                                : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                        border: isCurrent
                            ? Border.all(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2,
                              )
                            : null,
                      ),
                      child: Center(
                                                 child: Text(
                           '${index + 1}',
                           style: const TextStyle(
                             color: Colors.white,
                             fontWeight: FontWeight.bold,
                             fontSize: 16,
                           ),
                         ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegendItem(context, Colors.green, 'Correct'),
                _buildLegendItem(context, Colors.red, 'Incorrect'),
                _buildLegendItem(
                  context, 
                  Theme.of(context).colorScheme.primary, 
                  'Current'
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}