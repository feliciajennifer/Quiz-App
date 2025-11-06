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
        if (isCorrect) return AppColors.success;
        if (isSelected && !isCorrect) return AppColors.error;
      }
      return isSelected
          ? AppColors.primary
          : Colors.grey[300]!;
    }

    Color getBackgroundColor() {
      if (showCorrect) {
        if (isCorrect) return AppColors.success.withOpacity(0.1);
        if (isSelected && !isCorrect) return AppColors.error.withOpacity(0.1);
      }
      return isSelected
          ? AppColors.primary.withOpacity(0.1)
          : Theme.of(context).cardColor;
    }

    IconData? getIcon() {
      if (showCorrect) {
        if (isCorrect) return Icons.check_circle;
        if (isSelected && !isCorrect) return Icons.cancel;
      }
      return isSelected ? Icons.radio_button_checked : null;
    }

    Color getIconColor() {
      if (showCorrect) {
        if (isCorrect) return AppColors.success;
        if (isSelected && !isCorrect) return AppColors.error;
      }
      return AppColors.primary;
    }

    double getCardRadius() {
      return 12.0; 
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(getCardRadius()),
        side: BorderSide(
          color: getBorderColor(),
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(getCardRadius()),
        child: Container(
          padding: const EdgeInsets.all(16), 
          decoration: BoxDecoration(
            color: getBackgroundColor(),
            borderRadius: BorderRadius.circular(getCardRadius()),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                    fontFamily: 'Nunito',
                  ),
                ),
              ),
              if (getIcon() != null)
                Icon(
                  getIcon(),
                  color: getIconColor(),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}