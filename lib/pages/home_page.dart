import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/quiz_model.dart';
import '../models/theme_model.dart';
import '../utils/constants.dart';
import '../utils/quiz_data.dart';
import '../utils/categories_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/quiz_card.dart';
import '../widgets/category_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final quizModel = Provider.of<QuizModel>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Thinkzone',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () {
              final themeModel = Provider.of<ThemeModel>(context, listen: false);
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
            // Welcome Section dengan nama user
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${userModel.name}! 👋',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: AppDimensions.smallPadding),
                  const Text(
                    "Let's test your knowledge and have fun learning!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'Nunito',
                    ),
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  // User Stats
                  Row(
                    children: [
                      _buildStatItem('Quizzes', '0', Icons.quiz),
                      const SizedBox(width: AppDimensions.mediumPadding),
                      _buildStatItem('Score', '0', Icons.emoji_events),
                      const SizedBox(width: AppDimensions.mediumPadding),
                      _buildStatItem('Level', '1', Icons.star),
                    ],
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/quizzes');
                  },
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.mediumPadding),

            // Popular Quizzes List
            SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularQuizzes.length,
                itemBuilder: (context, index) {
                  final quiz = popularQuizzes[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: AppDimensions.mediumPadding),
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

            // Quick Categories Section
            Text(
              'Quick Categories',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppDimensions.mediumPadding),

            // Categories Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppDimensions.mediumPadding,
                mainAxisSpacing: AppDimensions.mediumPadding,
                childAspectRatio: 1.5,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return CategoryCard(
                  category: category,
                  onTap: () {
                    quizModel.setCategory(category['name']);
                    Navigator.pushNamed(context, '/quizzes');
                  },
                );
              },
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Daily Challenge Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.mediumPadding),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: AppColors.accent.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.bolt,
                    color: AppColors.accent,
                    size: 40,
                  ),
                  const SizedBox(width: AppDimensions.mediumPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daily Challenge',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Complete today\'s special quiz for bonus points!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to daily challenge
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimensions.buttonRadius),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.smallPadding),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Nunito',
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withOpacity(0.8),
                fontFamily: 'Nunito',
              ),
            ),
          ],
        ),
      ),
    );
  }
}