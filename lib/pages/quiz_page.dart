import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/progress_bar.dart';
import '../widgets/answer_card.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final questions = quizModel.questions;
    final userAnswers = quizModel.userAnswers;

    if (questions.isEmpty) {
      return Scaffold(
        appBar: const CustomAppBar(title: 'Kuis', showBackButton: true),
        body: const Center(child: Text('Tidak ada pertanyaan')),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];
    final userAnswer = userAnswers[_currentQuestionIndex];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Kuis', showBackButton: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.mediumPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress Bar
              ProgressBar(
                currentQuestion: _currentQuestionIndex,
                totalQuestions: questions.length,
              ),
              
              const SizedBox(height: AppConstants.largePadding),
              
              // Question
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.mediumPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pertanyaan ${_currentQuestionIndex + 1}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppConstants.smallPadding),
                      Text(
                        currentQuestion['question'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: AppConstants.mediumPadding),
              
              // Answers
              Expanded(
                child: ListView.builder(
                  itemCount: (currentQuestion['answers'] as List).length,
                  itemBuilder: (context, index) {
                    final answer = currentQuestion['answers'][index];
                    final isSelected = userAnswer == index;
                    final isCorrect = index == currentQuestion['correctAnswer'];
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppConstants.smallPadding),
                      child: AnswerCard(
                        answer: answer,
                        isSelected: isSelected,
                        isCorrect: isCorrect,
                        showCorrect: _showResult,
                        onTap: () {
                          if (!_showResult) {
                            quizModel.setAnswer(_currentQuestionIndex, index);
                            setState(() {});
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
              
              // Navigation Buttons
              Row(
                children: [
                  // Previous Button
                  if (_currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _currentQuestionIndex--;
                            _showResult = false;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                          ),
                        ),
                        child: const Text('Sebelumnya'),
                      ),
                    ),
                  
                  if (_currentQuestionIndex > 0) 
                    const SizedBox(width: AppConstants.smallPadding),
                  
                  // Next/Check/Finish Button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        if (userAnswer == null && !_showResult) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Silakan pilih jawaban terlebih dahulu!'),
                            ),
                          );
                          return;
                        }
                        
                        if (!_showResult) {
                          setState(() {
                            _showResult = true;
                          });
                        } else {
                          if (_currentQuestionIndex < questions.length - 1) {
                            setState(() {
                              _currentQuestionIndex++;
                              _showResult = false;
                            });
                          } else {
                            Navigator.pushNamed(context, '/result');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                      ),
                      child: Text(
                        _showResult
                            ? (_currentQuestionIndex < questions.length - 1 
                                ? 'Lanjut' 
                                : 'Lihat Hasil')
                            : 'Periksa Jawaban',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'Inter',
                        ),
                      ),
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