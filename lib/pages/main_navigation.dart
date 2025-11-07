import 'package:flutter/material.dart';
import 'home_page.dart';
import 'quizzes_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const QuizzesPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: 'Nunito',
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Nunito',
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/home.png',
                width: 24,
                height: 24,
                color: _currentIndex == 0 ? Colors.green : Colors.grey,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika image tidak ditemukan
                  return Icon(
                    Icons.home_rounded,
                    color: _currentIndex == 0 ? Colors.green : Colors.grey,
                    size: 24,
                  );
                },
              ),
              activeIcon: Image.asset(
                'assets/images/home.png',
                width: 24,
                height: 24,
                color: Colors.green,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika image tidak ditemukan
                  return Icon(
                    Icons.home_rounded,
                    color: Colors.green,
                    size: 24,
                  );
                },
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/quiz.png',
                width: 24,
                height: 24,
                color: _currentIndex == 1 ? Colors.green : Colors.grey,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika image tidak ditemukan
                  return Icon(
                    Icons.quiz_rounded,
                    color: _currentIndex == 1 ? Colors.green : Colors.grey,
                    size: 24,
                  );
                },
              ),
              activeIcon: Image.asset(
                'assets/images/quiz.png',
                width: 24,
                height: 24,
                color: Colors.green,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback jika image tidak ditemukan
                  return Icon(
                    Icons.quiz_rounded,
                    color: Colors.green,
                    size: 24,
                  );
                },
              ),
              label: 'Quizzes',
            ),
          ],
        ),
      ),
    );
  }
}