import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  String getResultMessage(int score, int total) {
    final percentage = (score / total) * 100;
    
    if (percentage >= 80) return 'Luar Biasa!';
    if (percentage >= 60) return 'Bagus!';
    if (percentage >= 40) return 'Cukup Baik';
    return 'Perlu Belajar Lagi';
  }

  Color getResultColor(int score, int total, BuildContext context) {
    final percentage = (score / total) * 100;
    
    if (percentage >= 80) return AppConstants.correctColor;
    if (percentage >= 60) return Colors.orange;
    if (percentage >= 40) return Colors.yellow[700]!;
    return AppConstants.wrongColor;
  }

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final score = quizModel.getScore();
    final total = quizModel.questions.length;
    final userName = quizModel.userName;

    return Scaffold(
      appBar: const CustomAppBar(title: 'Hasil Kuis', showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: Column(
            children: [
              // Result Card
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.largePadding),
                  child: Column(
                    children: [
                      Text(
                        'Selamat $userName!',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                      
                      const SizedBox(height: AppConstants.largePadding),
                      
                      // Score Circle
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getResultColor(score, total, context).withOpacity(0.1),
                          border: Border.all(
                            color: getResultColor(score, total, context),
                            width: 4,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$score/$total',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: getResultColor(score, total, context),
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              '${((score / total) * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 16,
                                color: getResultColor(score, total, context),
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: AppConstants.largePadding),
                      
                      Text(
                        getResultMessage(score, total),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: getResultColor(score, total, context),
                          fontFamily: 'Inter',
                        ),
                      ),
                      
                      const SizedBox(height: AppConstants.mediumPadding),
                      
                      Text(
                        'Anda menjawab $score dari $total pertanyaan dengan benar',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Detailed Results
              Expanded(
                child: ListView.builder(
                  itemCount: quizModel.questions.length,
                  itemBuilder: (context, index) {
                    final question = quizModel.questions[index];
                    final userAnswer = quizModel.userAnswers[index];
                    final isCorrect = userAnswer == question['correctAnswer'];
                    
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCorrect 
                              ? AppConstants.correctColor 
                              : AppConstants.wrongColor,
                          child: Icon(
                            isCorrect ? Icons.check : Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          'Pertanyaan ${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        subtitle: Text(
                          isCorrect ? 'Benar' : 'Salah',
                          style: TextStyle(
                            color: isCorrect ? AppConstants.correctColor : AppConstants.wrongColor,
                          ),
                        ),
                        trailing: Text(
                          '${index + 1}',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/quiz');
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      child: const Text('Ulangi Kuis'),
                    ),
                  ),
                  
                  const SizedBox(width: AppConstants.smallPadding),
                  
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        quizModel.resetQuiz();
                        Navigator.pushNamedAndRemoveUntil(
                          context, 
                          '/', 
                          (route) => false
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      child: const Text('Kuis Baru'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}