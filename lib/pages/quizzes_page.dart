import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../utils/categories_data.dart';
import '../utils/quiz_data.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/quiz_card.dart';
import '../widgets/category_card.dart';

class QuizzesPage extends StatefulWidget {
  const QuizzesPage({super.key});

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final quizModel = Provider.of<QuizModel>(context, listen: false);
    quizModel.setSearchQuery(_searchController.text);
  }

  List<Map<String, dynamic>> _getFilteredQuizzes(String selectedCategory, String searchQuery) {
    List<Map<String, dynamic>> filtered = allQuizzes;

    // Filter by category
    if (selectedCategory != 'All') {
      filtered = filtered.where((quiz) => quiz['category'] == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quiz) =>
          quiz['title'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final filteredQuizzes = _getFilteredQuizzes(quizModel.selectedCategory, quizModel.searchQuery);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Explore Quizzes',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(AppDimensions.mediumPadding),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search quizzes...',
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.mediumPadding,
                    vertical: AppDimensions.smallPadding,
                  ),
                ),
              ),
            ),
          ),

          // Categories Horizontal List
          SizedBox(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.mediumPadding,
              ),
              children: [
                // All Categories
                Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.smallPadding),
                  child: FilterChip(
                    label: const Text('All'),
                    selected: quizModel.selectedCategory == 'All',
                    onSelected: (selected) {
                      quizModel.setCategory('All');
                    },
                    backgroundColor: Theme.of(context).cardColor,
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: quizModel.selectedCategory == 'All' 
                          ? Colors.white 
                          : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ),
                // Other Categories
                ...categories.map((category) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppDimensions.smallPadding),
                    child: FilterChip(
                      label: Text(category['name']),
                      selected: quizModel.selectedCategory == category['name'],
                      onSelected: (selected) {
                        quizModel.setCategory(category['name']);
                      },
                      backgroundColor: Theme.of(context).cardColor,
                      selectedColor: Color(category['color']),
                      labelStyle: TextStyle(
                        color: quizModel.selectedCategory == category['name'] 
                            ? Colors.white 
                            : Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),

          // Quizzes Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.mediumPadding),
              child: filteredQuizzes.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 60, color: Colors.grey),
                          SizedBox(height: AppDimensions.mediumPadding),
                          Text(
                            'No quizzes found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontFamily: 'Nunito',
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppDimensions.mediumPadding,
                        mainAxisSpacing: AppDimensions.mediumPadding,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredQuizzes.length,
                      itemBuilder: (context, index) {
                        final quiz = filteredQuizzes[index];
                        return QuizCard(
                          quiz: quiz,
                          onTap: () {
                            quizModel.setCurrentQuiz(quiz);
                            Navigator.pushNamed(context, '/quiz_detail');
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}