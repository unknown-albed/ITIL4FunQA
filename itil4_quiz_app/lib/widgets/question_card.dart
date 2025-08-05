import 'package:flutter/material.dart';
import '../models/question.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final int? selectedAnswerIndex;
  final bool showFeedback;
  final Function(int)? onAnswerSelected;
  final bool isReviewMode;

  const QuestionCard({
    super.key,
    required this.question,
    this.selectedAnswerIndex,
    required this.showFeedback,
    this.onAnswerSelected,
    this.isReviewMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question number and text
            Text(
              'Question ${question.id}',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Question text
            Text(
              question.questionText,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Answer options
            Expanded(
              child: ListView.builder(
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: _buildAnswerOption(context, index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerOption(BuildContext context, int index) {
    final isSelected = selectedAnswerIndex == index;
    final isCorrect = index == question.correctAnswerIndex;
    final showCorrectAnswer = showFeedback && isCorrect;
    final showIncorrectAnswer = showFeedback && isSelected && !isCorrect;
    
    Color? backgroundColor;
    Color? borderColor;
    Color? textColor;
    Widget? trailing;

    if (showFeedback) {
      if (showCorrectAnswer) {
        backgroundColor = Colors.green.withOpacity(0.1);
        borderColor = Colors.green;
        textColor = Colors.green.shade700;
        trailing = const Icon(Icons.check_circle, color: Colors.green);
      } else if (showIncorrectAnswer) {
        backgroundColor = Colors.red.withOpacity(0.1);
        borderColor = Colors.red;
        textColor = Colors.red.shade700;
        trailing = const Icon(Icons.cancel, color: Colors.red);
      }
    } else if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      borderColor = Theme.of(context).colorScheme.primary;
      textColor = Theme.of(context).colorScheme.onPrimaryContainer;
    }

    return InkWell(
      onTap: isReviewMode || showFeedback || onAnswerSelected == null
          ? null
          : () => onAnswerSelected!(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(
            color: borderColor ?? Theme.of(context).colorScheme.outline,
            width: borderColor != null ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Option letter (A, B, C, D)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor ?? Theme.of(context).colorScheme.outline,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  String.fromCharCode(65 + index), // A, B, C, D
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Option text
            Expanded(
              child: Text(
                question.options[index],
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: textColor,
                  fontWeight: isSelected || showCorrectAnswer || showIncorrectAnswer
                      ? FontWeight.w600
                      : FontWeight.normal,
                  height: 1.3,
                ),
              ),
            ),
            
            // Trailing icon for feedback
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing,
            ],
          ],
        ),
      ),
    );
  }
}