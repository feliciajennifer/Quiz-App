import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/quiz_model.dart';
import '../models/theme_model.dart';
import '../utils/constants.dart';
import '../utils/quiz_data.dart';
import '../widgets/quiz_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final quizModel = Provider.of<QuizModel>(context);
    final themeModel = Provider.of<ThemeModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              themeModel.isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            onPressed: () {
              themeModel.toggleTheme();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.primary,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: AppDimensions.getMediumPadding(context)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userModel.name}! 👋',
                              style: TextStyle(
                                fontSize: AppDimensions.getSubtitleFontSize(context),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Ready to challenge your mind?",
                              style: TextStyle(
                                fontSize: AppDimensions.getBodyFontSize(context) - 2,
                                color: Colors.white.withOpacity(0.9),
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppDimensions.getMediumPadding(context)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.rocket_launch,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Let\'s learn something new today!',
                          style: TextStyle(
                            fontSize: AppDimensions.getBodyFontSize(context) - 4,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Quizzes',
                  style: TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.headlineMedium?.color,
                    fontFamily: 'Nunito',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    '${popularQuizzes.length} quizzes',
                    style: TextStyle(
                      fontSize: AppDimensions.getBodyFontSize(context) - 4,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.getMediumPadding(context)),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularQuizzes.length,
                itemBuilder: (context, index) {
                  final quiz = popularQuizzes[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == popularQuizzes.length - 1 
                          ? 0 
                          : AppDimensions.getMediumPadding(context),
                    ),
                    child: QuizCard(
                      quiz: quiz,
                      onTap: () {
                        quizModel.setCurrentQuiz(quiz);
                        Navigator.pushNamed(context, '/quiz_detail');
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}