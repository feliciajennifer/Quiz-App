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
      appBar: AppBar(
        title: Text(
          hasSelection ? '$_selectedCategory Quizzes' : 'Explore Quizzes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600, 
            color: Colors.white,
            fontFamily: 'Nunito',
          ),
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: hasSelection
            ? IconButton(
                icon: const Icon(Icons.arrow_back, size: 20),
                onPressed: _resetSelection,
              )
            : null,
        elevation: 0,
        centerTitle: true,
      ),
      body: hasSelection 
          ? _buildQuizzesGrid(quizModel, categoryQuizzes)
          : _buildCategoriesGrid(),
    );
  }

  Widget _buildCategoriesGrid() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quiz Categories',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineMedium?.color,
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Choose a category to explore quizzes',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
              fontFamily: 'Nunito',
            ),
          ),
          SizedBox(height: AppDimensions.getLargePadding(context)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppDimensions.getGridCrossAxisCount(context),
              crossAxisSpacing: AppDimensions.getMediumPadding(context),
              mainAxisSpacing: AppDimensions.getMediumPadding(context),
              childAspectRatio: 1.2,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
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
          ),
        ],
      ),
    );
  }

  Widget _buildQuizzesGrid(QuizModel quizModel, List<Map<String, dynamic>> categoryQuizzes) {
    if (categoryQuizzes.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.getLargePadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.quiz_outlined,
                size: 60, 
                color: Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: 16), 
              Text(
                'No quizzes available',
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontFamily: 'Nunito',
                ),
              ),
              SizedBox(height: 8), 
              Text(
                'Check back later for new $_selectedCategory quizzes!',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.withOpacity(0.7),
                  fontFamily: 'Nunito',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _resetSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Back to Categories',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: AppDimensions.getGridCrossAxisCount(context),
          crossAxisSpacing: AppDimensions.getMediumPadding(context),
          mainAxisSpacing: AppDimensions.getMediumPadding(context),
          childAspectRatio: 0.8,
        ),
        itemCount: categoryQuizzes.length,
        itemBuilder: (context, index) {
          final quiz = categoryQuizzes[index];
          return QuizCard(
            quiz: quiz,
            onTap: () {
              quizModel.setCurrentQuiz(quiz);
              Navigator.pushNamed(context, '/quiz_detail');
            },
          );
        },
      ),
    );
  }
}