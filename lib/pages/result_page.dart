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
    if (percentage >= 60) return const Color(0xFFFF9800);
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final userModel = Provider.of<UserModel>(context);
    final quiz = quizModel.currentQuiz!;
    final score = quizModel.getScore();
    final total = quiz['questions'].length;
    final missed = total - score;
    final accuracy = ((score / total) * 100).toInt();

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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Result Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getResultColor(score, total),
                      _getResultColor(score, total).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      _getResultMessage(score, total),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You got $score out of $total questions correct',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    
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
                            '$accuracy%',
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

              const SizedBox(height: 24),

              Row(
                children: [
                  // Correct Answers
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Correct',
                      score.toString(),
                      AppColors.success,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Missed Answers
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Missed',
                      missed.toString(),
                      AppColors.error,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Accuracy
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Accuracy',
                      '$accuracy%',
                      AppColors.primary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Performance Message
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _getPerformanceColor(accuracy).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getPerformanceColor(accuracy).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/message.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback jika image tidak ditemukan
                        return Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: _getPerformanceColor(accuracy).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.emoji_events,
                            size: 30,
                            color: _getPerformanceColor(accuracy),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getPerformanceMessage(accuracy),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _getPerformanceColor(accuracy),
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        quizModel.resetQuiz();
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/main',
                          (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: AppColors.primary),
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        quizModel.resetQuiz();
                        quizModel.setCurrentQuiz(quiz);
                        Navigator.pushReplacementNamed(context, '/quiz_play');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Nunito',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

  Color _getPerformanceColor(int accuracy) {
    if (accuracy >= 80) return AppColors.success;
    if (accuracy >= 60) return const Color(0xFFFF9800);
    return AppColors.error;
  }

  String _getPerformanceMessage(int accuracy) {
    if (accuracy >= 90) return 'Outstanding performance! You\'re a quiz master!';
    if (accuracy >= 80) return 'Excellent work! You really know your stuff!';
    if (accuracy >= 70) return 'Great job! You\'re on the right track!';
    if (accuracy >= 60) return 'Good effort! Keep practicing to improve!';
    if (accuracy >= 50) return 'Not bad! Review the material and try again!';
    return 'Keep trying! Every attempt makes you better!';
  }
}