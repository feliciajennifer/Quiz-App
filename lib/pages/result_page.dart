import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../models/user_model.dart';
import '../utils/constants.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  String _getResultMessage(int score, int total) {
    final percentage = (score / total) * 100;
    
    if (percentage >= 90) return 'Outstanding! 🎉';
    if (percentage >= 80) return 'Excellent! 👏';
    if (percentage >= 70) return 'Great Job! 👍';
    if (percentage >= 60) return 'Good Work! 😊';
    if (percentage >= 50) return 'Not Bad! 🙂';
    return 'Keep Trying! 💪';
  }

  Color _getResultColor(int score, int total) {
    final percentage = (score / total) * 100;
    
    if (percentage >= 80) return AppColors.success;
    if (percentage >= 60) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final userModel = Provider.of<UserModel>(context);
    final quiz = quizModel.currentQuiz!;
    final score = quizModel.getScore();
    final total = quiz['questions'].length;

    // Save result to user history
    userModel.addQuizResult({
      'quizTitle': quiz['title'],
      'score': score,
      'total': total,
      'date': DateTime.now(),
    });

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.mediumPadding),
          child: Column(
            children: [
              // Result Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.largePadding),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getResultColor(score, total),
                      _getResultColor(score, total).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                ),
                child: Column(
                  children: [
                    Text(
                      _getResultMessage(score, total),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.mediumPadding),
                    
                    // Score Circle
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$score/$total',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                          ),
                          Text(
                            '${((score / total) * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.largePadding),

              // Quiz Info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppDimensions.mediumPadding),
                  child: Column(
                    children: [
                      Text(
                        quiz['title'],
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppDimensions.smallPadding),
                      Text(
                        quiz['category'],
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.largePadding),

              // Question Review
              Expanded(
                child: ListView.builder(
                  itemCount: quiz['questions'].length,
                  itemBuilder: (context, index) {
                    final question = quiz['questions'][index];
                    final userAnswer = quizModel.userAnswers[index];
                    final isCorrect = userAnswer == question['correctAnswer'];
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppDimensions.smallPadding),
                      color: isCorrect 
                          ? AppColors.success.withOpacity(0.1)
                          : AppColors.error.withOpacity(0.1),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCorrect ? AppColors.success : AppColors.error,
                          child: Icon(
                            isCorrect ? Icons.check : Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          'Question ${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        subtitle: Text(
                          isCorrect ? 'Correct' : 'Incorrect',
                          style: TextStyle(
                            color: isCorrect ? AppColors.success : AppColors.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        quizModel.resetQuiz();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                        ),
                      ),
                      child: const Text('Back to Home'),
                    ),
                  ),
                  
                  const SizedBox(width: AppDimensions.smallPadding),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Reset answers but keep same quiz
                        quizModel.resetQuiz();
                        quizModel.setCurrentQuiz(quiz);
                        Navigator.pushReplacementNamed(context, '/quiz_play');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                        ),
                      ),
                      child: const Text('Try Again'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}