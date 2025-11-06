import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/theme_model.dart';
import 'models/quiz_model.dart';
import 'models/user_model.dart';
import 'pages/splash_screen.dart';
import 'pages/welcome_page.dart';
import 'pages/main_navigation.dart';
import 'pages/quiz_detail_page.dart'; // TAMBAH IMPORT INI
import 'pages/quiz_play_page.dart';   // TAMBAH IMPORT INI
import 'pages/result_page.dart';      // TAMBAH IMPORT INI

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
          home: const SplashScreen(),
          routes: {
            '/welcome': (context) => const WelcomePage(),
            '/main': (context) => const MainNavigation(),
            '/quiz_detail': (context) => const QuizDetailPage(),
            '/quiz_play': (context) => const QuizPlayPage(),
            '/result': (context) => const ResultPage(),
          },
        );
      },
    );
  }
}