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