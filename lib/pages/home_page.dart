import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../models/quiz_model.dart';
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
            // Welcome Section
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
                    'Hello, ${userModel.name.isNotEmpty ? userModel.name : 'Explorer'}!',
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
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.largePadding),

            // Popular Quizzes Section
            Text(
              'Popular Quizzes',
              style: Theme.of(context).textTheme.headlineMedium,
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
    );
  }
}