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
    final cardWidth = screenWidth < 360 ? 160.0 : 200.0;
    final imageHeight = screenWidth < 360 ? 100.0 : 120.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.getCardRadius(context)),
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
            // Quiz Image dengan responsive height
            Container(
              height: imageHeight,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppDimensions.getCardRadius(context)),
                  topRight: Radius.circular(AppDimensions.getCardRadius(context)),
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
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        quiz['difficulty'],
                        style: TextStyle(
                          fontSize: screenWidth < 360 ? 8 : 10,
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
                      size: screenWidth < 360 ? 30 : 40,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            
            // Quiz Info
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(AppDimensions.getMediumPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz['title'],
                          style: TextStyle(
                            fontSize: AppDimensions.getBodyFontSize(context) - 2,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                            fontFamily: 'Nunito',
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text(
                          quiz['category'],
                          style: TextStyle(
                            fontSize: AppDimensions.getBodyFontSize(context) - 4,
                            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.6),
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: screenWidth < 360 ? 12 : 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${quiz['questionCount']}',
                              style: TextStyle(
                                fontSize: AppDimensions.getBodyFontSize(context) - 4,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              size: screenWidth < 360 ? 12 : 14,
                              color: AppColors.primary,
                            ),
                            SizedBox(width: 4),
                            Text(
                              '${quiz['duration']}m',
                              style: TextStyle(
                                fontSize: AppDimensions.getBodyFontSize(context) - 4,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).textTheme.bodyLarge?.color,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
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
}