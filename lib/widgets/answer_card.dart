import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool showCorrect;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.showCorrect,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color getBorderColor() {
      if (showCorrect) {
        if (isCorrect) return AppConstants.correctColor;
        if (isSelected && !isCorrect) return AppConstants.wrongColor;
      }
      return isSelected
          ? Theme.of(context).primaryColor
          : Colors.grey[300]!;
    }

    Color getBackgroundColor() {
      if (showCorrect) {
        if (isCorrect) return AppConstants.correctColor.withOpacity(0.1);
        if (isSelected && !isCorrect) return AppConstants.wrongColor.withOpacity(0.1);
      }
      return isSelected
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : Colors.transparent;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        side: BorderSide(
          color: getBorderColor(),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Container(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  answer,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                ),
              ),
              if (showCorrect && isCorrect)
                Icon(
                  Icons.check_circle,
                  color: AppConstants.correctColor,
                ),
              if (showCorrect && isSelected && !isCorrect)
                Icon(
                  Icons.cancel,
                  color: AppConstants.wrongColor,
                ),
            ],
          ),
        ),
      ),
    );
  }
}