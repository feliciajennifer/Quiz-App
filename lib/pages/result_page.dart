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
          padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
          child: Column(
            children: [
              // Result Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppDimensions.getLargePadding(context)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getResultColor(score, total),
                      _getResultColor(score, total).withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
                ),
                child: Column(
                  children: [
                    Text(
                      _getResultMessage(score, total),
                      style: TextStyle(
                        fontSize: AppDimensions.getTitleFontSize(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.getSmallPadding(context)),
                    Text(
                      'You got $score out of $total questions correct',
                      style: TextStyle(
                        fontSize: AppDimensions.getBodyFontSize(context),
                        color: Colors.white.withOpacity(0.9),
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: AppDimensions.getMediumPadding(context)),
                    
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

              SizedBox(height: AppDimensions.getLargePadding(context)),

              Row(
                children: [
                  // Correct Answers
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Correct',
                      score.toString(),
                      AppColors.success,
                      Icons.check_circle,
                    ),
                  ),
                  SizedBox(width: AppDimensions.getSmallPadding(context)),
                  // Missed Answers
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Missed',
                      missed.toString(),
                      AppColors.error,
                      Icons.cancel,
                    ),
                  ),
                  SizedBox(width: AppDimensions.getSmallPadding(context)),
                  // Accuracy
                  Expanded(
                    child: _buildStatCard(
                      context,
                      'Accuracy',
                      '$accuracy%',
                      AppColors.primary,
                      Icons.analytics,
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppDimensions.getLargePadding(context)),

              // Quiz Info
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                  child: Column(
                    children: [
                      Text(
                        quiz['title'],
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.getSmallPadding(context)),
                      Text(
                        quiz['category'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                      SizedBox(height: AppDimensions.getSmallPadding(context)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timer,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${quiz['duration']} minutes',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                          SizedBox(width: 16),
                          Icon(
                            Icons.question_answer,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '${quiz['questionCount']} questions',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.getLargePadding(context)),

              // Performance Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                decoration: BoxDecoration(
                  color: _getPerformanceColor(accuracy).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
                  border: Border.all(
                    color: _getPerformanceColor(accuracy).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      _getPerformanceIcon(accuracy),
                      size: 40,
                      color: _getPerformanceColor(accuracy),
                    ),
                    SizedBox(height: AppDimensions.getSmallPadding(context)),
                    Text(
                      _getPerformanceMessage(accuracy),
                      style: TextStyle(
                        fontSize: AppDimensions.getBodyFontSize(context),
                        fontWeight: FontWeight.w600,
                        color: _getPerformanceColor(accuracy),
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppDimensions.getLargePadding(context)),

              // Question Review Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question Review',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      '$score/$total correct',
                      style: TextStyle(
                        fontSize: AppDimensions.getBodyFontSize(context) - 2,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: AppDimensions.getMediumPadding(context)),

              // Question Review List
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: quiz['questions'].length,
                  itemBuilder: (context, index) {
                    final question = quiz['questions'][index];
                    final userAnswer = quizModel.userAnswers[index];
                    final isCorrect = userAnswer == question['correctAnswer'];
                    
                    return Card(
                      margin: EdgeInsets.only(bottom: AppDimensions.getSmallPadding(context)),
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

              SizedBox(height: AppDimensions.getLargePadding(context)),

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
                          borderRadius: BorderRadius.circular(AppDimensions.getButtonRadius(context)),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: AppDimensions.getBodyFontSize(context),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(width: AppDimensions.getSmallPadding(context)),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        quizModel.resetQuiz();
                        quizModel.setCurrentQuiz(quiz);
                        Navigator.pushReplacementNamed(context, '/quiz_play');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.getButtonRadius(context)),
                        ),
                      ),
                      child: Text(
                        'Try Again',
                        style: TextStyle(
                          fontSize: AppDimensions.getBodyFontSize(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          SizedBox(height: AppDimensions.getSmallPadding(context)),
          Text(
            value,
            style: TextStyle(
              fontSize: AppDimensions.getSubtitleFontSize(context),
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: AppDimensions.getBodyFontSize(context) - 2,
              color: AppColors.textSecondary,
              fontFamily: 'Nunito',
            ),
          ),
        ],
      ),
    );
  }

  Color _getPerformanceColor(int accuracy) {
    if (accuracy >= 80) return AppColors.success;
    if (accuracy >= 60) return AppColors.warning;
    return AppColors.error;
  }

  IconData _getPerformanceIcon(int accuracy) {
    if (accuracy >= 80) return Icons.emoji_events;
    if (accuracy >= 60) return Icons.thumb_up;
    return Icons.lightbulb_outline;
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