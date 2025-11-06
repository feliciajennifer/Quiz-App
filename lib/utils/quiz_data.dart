List<Map<String, dynamic>> allQuizzes = [
  {
    'id': '1',
    'title': 'Flutter Basics',
    'category': 'Technology',
    'image': 'assets/images/flutter_quiz.jpg',
    'questionCount': 10,
    'duration': 15,
    'description': 'Test your knowledge about Flutter framework and Dart programming language',
    'difficulty': 'Beginner',
    'questions': [
      {
        'question': 'What is Flutter?',
        'answers': [
          'A mobile app SDK',
          'A programming language',
          'A database',
          'A design tool'
        ],
        'correctAnswer': 0,
      },
      {
        'question': 'Which language is used in Flutter?',
        'answers': [
          'Dart',
          'Java',
          'Swift',
          'Kotlin'
        ],
        'correctAnswer': 0,
      },
    ],
  },
  {
    'id': '2',
    'title': 'Solar System',
    'category': 'Astronomy',
    'image': 'assets/images/space_quiz.jpg',
    'questionCount': 8,
    'duration': 12,
    'description': 'Explore the wonders of our solar system and beyond',
    'difficulty': 'Intermediate',
    'questions': [
      {
        'question': 'Which planet is known as the Red Planet?',
        'answers': [
          'Mars',
          'Jupiter',
          'Venus',
          'Saturn'
        ],
        'correctAnswer': 0,
      },
    ],
  },
];

List<Map<String, dynamic>> popularQuizzes = [
  allQuizzes[0],
  allQuizzes[1],
];