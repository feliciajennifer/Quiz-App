import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../widgets/answer_card.dart';

class QuizPlayPage extends StatefulWidget {
  const QuizPlayPage({super.key});

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  int _currentQuestionIndex = 0;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final quiz = quizModel.currentQuiz!;
    final questions = quiz['questions'];
    final userAnswers = quizModel.userAnswers;

    final currentQuestion = questions[_currentQuestionIndex];
    final userAnswer = userAnswers[_currentQuestionIndex];
    final correctAnswer = currentQuestion['correctAnswer'];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          quiz['title'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headlineMedium?.color,
            fontFamily: 'Nunito',
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress Bar
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ${_currentQuestionIndex + 1} of ${questions.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: (_currentQuestionIndex + 1) / questions.length,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Question Card
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          currentQuestion['question'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headlineMedium?.color,
                            fontFamily: 'Nunito',
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Answers
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentQuestion['answers'].length,
                      itemBuilder: (context, index) {
                        final answer = currentQuestion['answers'][index];
                        final isSelected = userAnswer == index;
                        final isCorrect = index == correctAnswer;
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AnswerCard(
                            answer: answer,
                            isSelected: isSelected,
                            isCorrect: isCorrect,
                            showCorrect: _showResult, 
                            onTap: () {
                              if (!_showResult) {
                                quizModel.setAnswer(_currentQuestionIndex, index);
                                setState(() {});
                              }
                            },
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            // Navigation Buttons
            Row(
              children: [
                // Previous Button
                if (_currentQuestionIndex > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentQuestionIndex--;
                          _showResult = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: AppColors.primary),
                      ),
                      child: Text(
                        'Previous',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                
                if (_currentQuestionIndex > 0) 
                  const SizedBox(width: 12),
                
                // Next/Check Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (userAnswer == null && !_showResult) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Please select an answer first!',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                        return;
                      }
                      
                      if (!_showResult) {
                        setState(() {
                          _showResult = true;
                        });
                      } else {
                        if (_currentQuestionIndex < questions.length - 1) {
                          setState(() {
                            _currentQuestionIndex++;
                            _showResult = false;
                          });
                        } else {
                          Navigator.pushNamed(context, '/result');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _showResult
                          ? (_currentQuestionIndex < questions.length - 1 
                              ? 'Next Question' 
                              : 'Finish Quiz')
                          : 'Check Answer',
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}