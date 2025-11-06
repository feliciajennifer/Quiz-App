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
        padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quiz Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppDimensions.getLargePadding(context)),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
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
                  SizedBox(height: AppDimensions.getMediumPadding(context)),
                  Text(
                    quiz['title'],
                    style: TextStyle(
                      fontSize: AppDimensions.getSubtitleFontSize(context),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.getSmallPadding(context)),
                  Text(
                    quiz['category'],
                    style: TextStyle(
                      fontSize: AppDimensions.getBodyFontSize(context),
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: AppDimensions.getLargePadding(context)),

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
                SizedBox(width: AppDimensions.getMediumPadding(context)),
                Expanded(
                  child: _buildInfoCard(
                    context,
                    Icons.timer,
                    '${quiz['duration']} Minutes',
                  ),
                ),
              ],
            ),

            SizedBox(height: AppDimensions.getMediumPadding(context)),

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

            SizedBox(height: AppDimensions.getLargePadding(context)),

            // Description
            Text(
              'About This Quiz',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: AppDimensions.getMediumPadding(context)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
              ),
              child: Text(
                quiz['description'],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

            SizedBox(height: AppDimensions.getLargePadding(context)),

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
                    borderRadius: BorderRadius.circular(AppDimensions.getButtonRadius(context)),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'Start Quiz',
                  style: TextStyle(
                    fontSize: AppDimensions.getBodyFontSize(context),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ),

            SizedBox(height: AppDimensions.getMediumPadding(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: AppDimensions.getSmallPadding(context)),
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