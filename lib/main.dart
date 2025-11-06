import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/theme_model.dart';
import 'models/quiz_model.dart';
import 'models/user_model.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/quizzes_page.dart';
import 'pages/quiz_detail_page.dart';
import 'pages/quiz_play_page.dart';
import 'pages/result_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeModel()),
        ChangeNotifierProvider(create: (context) => QuizModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return MaterialApp(
          title: 'Thinkzone',
          theme: themeModel.lightTheme,
          darkTheme: themeModel.darkTheme,
          themeMode: themeModel.themeMode,
          debugShowCheckedModeBanner: false,
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/home': (context) => const HomePage(),
            '/quizzes': (context) => const QuizzesPage(),
            '/quiz_detail': (context) => const QuizDetailPage(),
            '/quiz_play': (context) => const QuizPlayPage(),
            '/result': (context) => const ResultPage(),
          },
        );
      },
    );
  }
}