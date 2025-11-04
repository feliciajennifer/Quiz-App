import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/quiz_model.dart';
import '../utils/constants.dart';
import '../utils/quiz_data.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizModel = Provider.of<QuizModel>(context);
    final TextEditingController nameController = TextEditingController();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Kuis Pintar',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.mediumPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header Image
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              margin: const EdgeInsets.only(bottom: AppConstants.largePadding),
              child: Image.asset(
                'assets/quiz_icon.png', // Pastikan Anda menambahkan gambar ini di folder assets
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.quiz,
                    size: 120,
                    color: Theme.of(context).primaryColor,
                  );
                },
              ),
            ),
            
            // Title
            Text(
              'Selamat Datang!',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppConstants.smallPadding),
            
            Text(
              'Uji pengetahuan Anda dengan kuis menarik ini',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Name Input
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.mediumPadding),
                child: Column(
                  children: [
                    Text(
                      'Masukkan Nama Anda',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: AppConstants.mediumPadding),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Nama Anda...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                        ),
                        prefixIcon: const Icon(Icons.person),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Quiz Info
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.borderRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.mediumPadding),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.help_outline,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        '${quizQuestions.length} Pertanyaan',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.timer,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        'Waktu Tidak Terbatas',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.emoji_events,
                        color: Theme.of(context).primaryColor,
                      ),
                      title: Text(
                        'Lihat Skor Akhir',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Start Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Silakan masukkan nama Anda terlebih dahulu!'),
                      ),
                    );
                    return;
                  }
                  
                  quizModel.userName = nameController.text.trim();
                  quizModel.setQuestions(quizQuestions);
                  
                  Navigator.pushNamed(context, '/quiz');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.borderRadius),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Mulai Kuis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}