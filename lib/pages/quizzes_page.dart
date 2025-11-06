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
  String? _selectedCategory;
  final Map<String, List<Map<String, dynamic>>> _quizzesByCategory = getQuizzesByCategory();

  List<Map<String, dynamic>> getQuizzesForSelectedCategory() {
    if (_selectedCategory == null) {
      return [];
    }
    return _quizzesByCategory[_selectedCategory] ?? [];
  }

  void _resetSelection() {
    setState(() {
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final categoryQuizzes = getQuizzesForSelectedCategory();
    final hasSelection = _selectedCategory != null;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              hasSelection ? '$_selectedCategory Quizzes' : 'Explore Quizzes',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            backgroundColor: AppColors.primary,
            expandedHeight: 120,
            floating: false,
            pinned: true,
            leading: hasSelection
                ? IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _resetSelection,
                  )
                : null,
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

          if (!hasSelection) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Categories',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: AppDimensions.getMediumPadding(context)),
                    Text(
                      'Choose a category to explore quizzes',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                          ),
                    ),
                    SizedBox(height: AppDimensions.getLargePadding(context)),
                  ],
                ),
              ),
            ),

            // Categories Grid
            SliverPadding(
              padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: AppDimensions.getGridCrossAxisCount(context),
                  crossAxisSpacing: AppDimensions.getMediumPadding(context),
                  mainAxisSpacing: AppDimensions.getMediumPadding(context),
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
                    final quizCount = _quizzesByCategory[category['name']]?.length ?? 0;
                    
                    return CategoryCard(
                      category: {
                        ...category,
                        'quizCount': quizCount,
                      },
                      onTap: () {
                        setState(() {
                          _selectedCategory = category['name'];
                        });
                      },
                    );
                  },
                  childCount: categories.length,
                ),
              ),
            ),
          ],

          if (hasSelection) ...[
            // Selected Category Info
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppDimensions.getMediumPadding(context),
                  right: AppDimensions.getMediumPadding(context),
                  top: AppDimensions.getLargePadding(context),
                  bottom: AppDimensions.getMediumPadding(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_selectedCategory Quizzes',
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
                          fontSize: AppDimensions.getBodyFontSize(context) - 4,
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

            // Quizzes Grid untuk kategori yang dipilih
            if (categoryQuizzes.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(AppDimensions.getLargePadding(context)),
                  child: Column(
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 80,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(height: AppDimensions.getMediumPadding(context)),
                      Text(
                        'No quizzes available in $_selectedCategory',
                        style: TextStyle(
                          fontSize: AppDimensions.getBodyFontSize(context),
                          color: Colors.grey,
                          fontFamily: 'Nunito',
                        ),
                      ),
                      SizedBox(height: AppDimensions.getSmallPadding(context)),
                      Text(
                        'Check back later for new quizzes!',
                        style: TextStyle(
                          fontSize: AppDimensions.getBodyFontSize(context) - 2,
                          color: Colors.grey.withOpacity(0.7),
                          fontFamily: 'Nunito',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: AppDimensions.getMediumPadding(context)),
                      ElevatedButton(
                        onPressed: _resetSelection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        child: const Text('Back to Categories'),
                      ),
                    ],
                  ),
                ),
              )
            else
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
          ],
        ],
      ),
    );
  }
}