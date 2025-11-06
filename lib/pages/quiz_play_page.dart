import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../widgets/progress_timer.dart';
import '../widgets/answer_card.dart';

class QuizPlayPage extends StatefulWidget {
  const QuizPlayPage({super.key});

  @override
  State<QuizPlayPage> createState() => _QuizPlayPageState();
}

class _QuizPlayPageState extends State<QuizPlayPage> {
  int _currentQuestionIndex = 0;
  bool _showResult = false;
  late int _totalTimeInSeconds;

  @override
  void initState() {
    super.initState();
    final quizModel = Provider.of<QuizModel>(context, listen: false);
    _totalTimeInSeconds = quizModel.currentQuiz!['duration'] * 60;
  }

  void _showSubmitConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End the Quiz Already?'),
        content: const Text('You still have some time left! Are you sure you want to submit your answers now?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/result');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final quiz = quizModel.currentQuiz!;
    final questions = quiz['questions'];
    final userAnswers = quizModel.userAnswers;

    final currentQuestion = questions[_currentQuestionIndex];
    final userAnswer = userAnswers[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          quiz['title'],
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: _showSubmitConfirmation,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.mediumPadding),
        child: Column(
          children: [
            // Progress and Timer
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: (_currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  ),
                ),
                const SizedBox(width: AppDimensions.mediumPadding),
                ProgressTimer(
                  totalTimeInSeconds: _totalTimeInSeconds,
                  onTimeUp: () {
                    Navigator.pushNamed(context, '/result');
                  },
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Question Number
            Text(
              'Question ${_currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito',
              ),
            ),

            const SizedBox(height: AppDimensions.mediumPadding),

            // Question Card
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(AppDimensions.largePadding),
                        child: Text(
                          currentQuestion['question'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Nunito',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),

                    const SizedBox(height: AppDimensions.largePadding),

                    // Answers
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentQuestion['answers'].length,
                      itemBuilder: (context, index) {
                        final answer = currentQuestion['answers'][index];
                        final isSelected = userAnswer == index;
                        final isCorrect = index == currentQuestion['correctAnswer'];
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppDimensions.smallPadding),
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
                          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                        ),
                      ),
                      child: const Text('Previous'),
                    ),
                  ),
                
                if (_currentQuestionIndex > 0) 
                  const SizedBox(width: AppDimensions.smallPadding),
                
                // Next/Check/Submit Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (userAnswer == null && !_showResult) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an answer first!'),
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
                          _showSubmitConfirmation();
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                      ),
                    ),
                    child: Text(
                      _showResult
                          ? (_currentQuestionIndex < questions.length - 1 
                              ? 'Next Question' 
                              : 'Submit Quiz')
                          : 'Check Answer',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}