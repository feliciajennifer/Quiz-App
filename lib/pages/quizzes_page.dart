import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../utils/categories_data.dart';
import '../utils/quiz_data.dart';
import '../widgets/quiz_card.dart';
import '../widgets/category_card.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  String _selectedCategory = 'All';
  final Map<String, List<Map<String, dynamic>>> _quizzesByCategory = getQuizzesByCategory();

  List<Map<String, dynamic>> getQuizzesForSelectedCategory() {
    if (_selectedCategory == 'All') {
      return allQuizzes;
    }
    return _quizzesByCategory[_selectedCategory] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final categoryQuizzes = getQuizzesForSelectedCategory();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Explore Quizzes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            backgroundColor: AppColors.primary,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.secondary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),

          // Categories Grid Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.mediumPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Categories',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: AppDimensions.mediumPadding),
                  GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: AppDimensions.getGridCrossAxisCount(context),
    crossAxisSpacing: AppDimensions.getMediumPadding(context),
    mainAxisSpacing: AppDimensions.getMediumPadding(context),
    childAspectRatio: AppDimensions.getGridChildAspectRatio(context),
  ),
  itemCount: categories.length,
  itemBuilder: (context, index) {
    final category = categories[index];
    return CategoryCard(
      category: category,
      onTap: () {
        setState(() {
          _selectedCategory = category['name'];
        });
      },
    );
  },
),

// Di bagian SliverGrid untuk quizzes, ganti dengan:
SliverPadding(
  padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
  sliver: SliverGrid(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: AppDimensions.getGridCrossAxisCount(context),
      crossAxisSpacing: AppDimensions.getMediumPadding(context),
      mainAxisSpacing: AppDimensions.getMediumPadding(context),
      childAspectRatio: 0.8,
    ),
    delegate: SliverChildBuilderDelegate(
      (context, index) {
        final quiz = categoryQuizzes[index];
        return QuizCard(
          quiz: quiz,
          onTap: () {
            quizModel.setCurrentQuiz(quiz);
            Navigator.pushNamed(context, '/quiz_detail');
          },
        );
      },
      childCount: categoryQuizzes.length,
    ),
  ),
),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.mediumPadding,
                right: AppDimensions.mediumPadding,
                top: AppDimensions.largePadding,
                bottom: AppDimensions.mediumPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedCategory == 'All' 
                        ? 'All Quizzes' 
                        : '${_selectedCategory} Quizzes',
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
                      '${categoryQuizzes.length} quiz${categoryQuizzes.length != 1 ? 'zes' : ''}',
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
            ),
          ),

          // Quizzes Grid
          if (categoryQuizzes.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.largePadding),
                child: Column(
                  children: [
                    Icon(
                      Icons.quiz_outlined,
                      size: 80,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    const SizedBox(height: AppDimensions.mediumPadding),
                    Text(
                      'No quizzes available',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    const SizedBox(height: AppDimensions.smallPadding),
                    Text(
                      'Check back later for new quizzes!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.withOpacity(0.7),
                        fontFamily: 'Nunito',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(AppDimensions.mediumPadding),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppDimensions.mediumPadding,
                  mainAxisSpacing: AppDimensions.mediumPadding,
                  childAspectRatio: 0.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final quiz = categoryQuizzes[index];
                    return QuizCard(
                      quiz: quiz,
                      onTap: () {
                        quizModel.setCurrentQuiz(quiz);
                        Navigator.pushNamed(context, '/quiz_detail');
                      },
                    );
                  },
                  childCount: categoryQuizzes.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}