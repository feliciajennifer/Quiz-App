import 'package:flutter/material.dart';
import '../utils/constants.dart';

class QuizCard extends StatelessWidget {
  final Map<String, dynamic> quiz;
  final VoidCallback onTap;

  const QuizCard({
    super.key,
    required this.quiz,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape = screenWidth > screenHeight;
    
    final cardWidth = _getCardWidth(screenWidth, isLandscape);
    final imageHeight = _getImageHeight(screenWidth, isLandscape);
    final fontSizeSmall = _getFontSizeSmall(screenWidth, isLandscape);
    final fontSizeMedium = _getFontSizeMedium(screenWidth, isLandscape);
    final iconSize = _getIconSize(screenWidth, isLandscape);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        margin: EdgeInsets.only(right: _getCardSpacing(screenWidth, isLandscape)),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(_getCardRadius(screenWidth, isLandscape)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_getCardRadius(screenWidth, isLandscape)),
                  topRight: Radius.circular(_getCardRadius(screenWidth, isLandscape)),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.secondary.withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        quiz['difficulty']?.toString().toUpperCase() ?? 'EASY',
                        style: TextStyle(
                          fontSize: fontSizeSmall - 2,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Icon(
                      Icons.quiz,
                      size: iconSize,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quiz Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(_getContentPadding(screenWidth, isLandscape)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz['title'] ?? 'Quiz Title',
                          style: TextStyle(
                            fontSize: fontSizeMedium,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: 'Nunito',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          quiz['category'] ?? 'General',
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                            fontFamily: 'Nunito',
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    
                    Row(
                      children: [
                        Icon(
                          Icons.question_answer,
                          size: iconSize - 20,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${quiz['questionCount'] ?? 0} Questions',
                          style: TextStyle(
                            fontSize: fontSizeSmall,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  double _getCardWidth(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 160.0;
      if (screenWidth < 900) return 180.0;
      return 200.0;
    }
    
    if (screenWidth < 360) return 140.0;
    if (screenWidth < 400) return 160.0;
    if (screenWidth < 600) return 180.0;
    if (screenWidth < 900) return 200.0;
    return 220.0; 
  }

  double _getImageHeight(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 90.0;
      if (screenWidth < 900) return 100.0;
      return 110.0;
    }
    
    if (screenWidth < 360) return 80.0;
    if (screenWidth < 400) return 90.0;
    if (screenWidth < 600) return 100.0;
    if (screenWidth < 900) return 110.0;
    return 120.0; 
  }

  double _getCardRadius(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      return 12.0;
    }
    
    if (screenWidth < 360) return 10.0;
    if (screenWidth < 400) return 12.0;
    return 16.0;
  }

  double _getContentPadding(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 8.0;
      return 10.0;
    }
    
    if (screenWidth < 360) return 8.0;
    if (screenWidth < 400) return 10.0;
    return 12.0;
  }

  double _getCardSpacing(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 8.0;
      return 10.0;
    }
    
    if (screenWidth < 360) return 8.0;
    if (screenWidth < 400) return 10.0;
    return 12.0;
  }

  double _getFontSizeSmall(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 10.0;
      return 11.0;
    }
    
    if (screenWidth < 360) return 10.0;
    if (screenWidth < 400) return 11.0;
    if (screenWidth < 600) return 12.0;
    return 13.0; 
  }

  double _getFontSizeMedium(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 12.0;
      return 13.0;
    }
    
    if (screenWidth < 360) return 12.0;
    if (screenWidth < 400) return 13.0;
    if (screenWidth < 600) return 14.0;
    return 15.0; 
  }

  double _getIconSize(double screenWidth, bool isLandscape) {
    if (isLandscape) {
      if (screenWidth < 600) return 28.0;
      if (screenWidth < 900) return 32.0;
      return 34.0;
    }
    
    if (screenWidth < 360) return 24.0;
    if (screenWidth < 400) return 28.0;
    if (screenWidth < 600) return 32.0;
    if (screenWidth < 900) return 34.0;
    return 36.0;
  }
}