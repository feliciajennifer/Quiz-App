import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';

class QuizDetailPage extends StatelessWidget {
  const QuizDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final quiz = quizModel.currentQuiz!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Quiz Details',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.largePadding),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              ),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.quiz,
                      size: 40,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  Text(
                    quiz['title'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.smallPadding),
                  Text(
                    quiz['category'],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Quiz Info Cards
            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    context,
                    Icons.question_answer,
                    '${quiz['questionCount']} Questions',
                  ),
                ),
                const SizedBox(width: AppDimensions.mediumPadding),
                Expanded(
                  child: _buildInfoCard(
                    context,
                    Icons.timer,
                    '${quiz['duration']} Minutes',
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.mediumPadding),

            Row(
              children: [
                Expanded(
                  child: _buildInfoCard(
                    context,
                    Icons.school,
                    quiz['difficulty'],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Description
            Text(
              'About This Quiz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppDimensions.mediumPadding),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.mediumPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              ),
              child: Text(
                quiz['description'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Start Quiz Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/quiz_play');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.mediumPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: AppDimensions.smallPadding),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}