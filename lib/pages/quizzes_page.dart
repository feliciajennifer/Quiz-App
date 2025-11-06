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
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((quiz) =>
          quiz['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          quiz['category'].toLowerCase().contains(searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final filteredQuizzes = _getFilteredQuizzes(quizModel.selectedCategory, quizModel.searchQuery);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
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

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
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
                    hintText: 'Search by title or category...',
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
                          // Scroll ke bagian quizzes
                          _scrollController.animateTo(
                            400,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Categories Horizontal Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.smallPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.mediumPadding,
                    ),
                    child: Text(
                      'Filter by Category:',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
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
                ],
              ),
            ),
          ),

          // Quizzes Grid Header
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
                    quizModel.selectedCategory == 'All' 
                        ? 'All Quizzes' 
                        : '${quizModel.selectedCategory} Quizzes',
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
                      '${filteredQuizzes.length} quizzes',
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
          filteredQuizzes.isEmpty
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppDimensions.largePadding),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        const SizedBox(height: AppDimensions.mediumPadding),
                        Text(
                          'No quizzes found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontFamily: 'Nunito',
                          ),
                        ),
                        const SizedBox(height: AppDimensions.smallPadding),
                        Text(
                          'Try changing your search or filter',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withOpacity(0.7),
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
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
                        final quiz = filteredQuizzes[index];
                        return QuizCard(
                          quiz: quiz,
                          onTap: () {
                            quizModel.setCurrentQuiz(quiz);
                            Navigator.pushNamed(context, '/quiz_detail');
                          },
                        );
                      },
                      childCount: filteredQuizzes.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}