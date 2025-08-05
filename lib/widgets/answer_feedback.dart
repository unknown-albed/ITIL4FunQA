import 'package:flutter/material.dart';
import '../models/question.dart';

class AnswerFeedback extends StatelessWidget {
  final Question question;
  final int selectedAnswerIndex;

  const AnswerFeedback({
    super.key,
    required this.question,
    required this.selectedAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = selectedAnswerIndex == question.correctAnswerIndex;
    
    return Card(
      color: isCorrect 
          ? Colors.green.withOpacity(0.1)
          : Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Feedback header
            Row(
              children: [
                Icon(
                  isCorrect ? Icons.check_circle : Icons.cancel,
                  color: isCorrect ? Colors.green : Colors.red,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isCorrect ? Colors.green.shade700 : Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Motivational message
            Text(
              isCorrect 
                  ? _getCorrectMessage()
                  : 'Don\'t worry, learning from mistakes helps you improve!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isCorrect ? Colors.green.shade600 : Colors.red.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
            
            // Show correct answer if user was wrong
            if (!isCorrect) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correct Answer:',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${String.fromCharCode(65 + question.correctAnswerIndex)}. ${question.correctAnswer}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            
            const SizedBox(height: 16),
            
            // Explanation section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Explanation',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.explanation,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCorrectMessage() {
    final messages = [
      'Excellent! You know your ITIL concepts well!',
      'Great job! Your understanding is on point!',
      'Perfect! You\'ve mastered this concept!',
      'Outstanding! Keep up the excellent work!',
      'Brilliant! Your ITIL knowledge is impressive!',
      'Well done! You\'re doing great!',
    ];
    
    // Use question ID to get consistent but varied messages
    return messages[question.id % messages.length];
  }
}