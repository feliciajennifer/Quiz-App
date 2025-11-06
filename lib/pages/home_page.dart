import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/quiz_model.dart';
import '../models/theme_model.dart';
import '../utils/constants.dart';
import '../utils/quiz_data.dart';
import '../widgets/bottom_nav_bar.dart';
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
        // HILANGKAN TULISAN THINKZONE
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
        padding: const EdgeInsets.all(AppDimensions.mediumPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      const SizedBox(width: AppDimensions.mediumPadding),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, ${userModel.name}! 👋',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Ready to challenge your mind?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.9),
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.mediumPadding,
                      vertical: AppDimensions.smallPadding,
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
                            fontSize: 12,
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

            // Popular Quizzes Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular Quizzes',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontFamily: 'Nunito',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.mediumPadding),

            // Popular Quizzes List
            SizedBox(
              height: 245,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularQuizzes.length,
                itemBuilder: (context, index) {
                  final quiz = popularQuizzes[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      right: index == popularQuizzes.length - 1 
                          ? 0 
                          : AppDimensions.mediumPadding,
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

            const SizedBox(height: AppDimensions.largePadding),

            // Explore More Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.largePadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
                color: Theme.of(context).cardColor,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.explore,
                    size: 50,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  Text(
                    'Explore More Quizzes',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.smallPadding),
                  Text(
                    'Discover hundreds of quizzes across different categories and difficulty levels',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/quizzes');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                        ),
                        elevation: 2,
                      ),
                      child: const Text(
                        'Browse All Quizzes',
                        style: TextStyle(
                          fontSize: 16,
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}